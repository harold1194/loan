import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/models/clients.dart';
import 'package:loan_app/provider/client_provider.dart';
import 'package:loan_app/provider/customer_provider.dart';
import 'package:loan_app/utils/custom_textfield.dart';

import '../models/customer.dart';
import '../utils/custom_button.dart';
import '../utils/my_colors.dart';

class EncodePage extends StatefulWidget {
  const EncodePage({super.key});

  @override
  State<EncodePage> createState() => _EncodePageState();
}

class _EncodePageState extends State<EncodePage> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController mnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();

  final List<Customer> _customers = [];

  final ClientProvider clientProvider = ClientProvider();

  int? clientId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                  hint: 'First Name',
                  textEditingController: fnameController,
                  icon: Icons.person),
              CustomTextFormField(
                  hint: 'Middle Name',
                  textEditingController: mnameController,
                  icon: Icons.person),
              CustomTextFormField(
                  hint: 'Last Name',
                  textEditingController: lnameController,
                  icon: Icons.person),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Customers",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                      onPressed: _addCustomers,
                      icon: Icon(
                        Icons.add,
                        color: AppColors().kIconColor,
                        size: 30,
                      ))
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _customers.length,
                itemBuilder: (context, index) {
                  final customer = _customers[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name ${customer.cnameController.text}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit,
                                        color: AppColors().kBlueBarColor),
                                    onPressed: () => _editCustomer(index),
                                  ),
                                ],
                              ),
                              Text(
                                "Good Purchased ${customer.goodsController.text}",
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                  "Contact Person ${customer.contactnameController.text}",
                                  style: const TextStyle(fontSize: 18)),
                              Text(
                                  "Contact No. ${customer.contactnoController.text}",
                                  style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              IconButton(
                                icon: const Icon(Icons.remove_circle),
                                color: AppColors().kRedBarColor,
                                onPressed: () => _removeCustomer(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    saveClient();
                  },
                  child: const Text("SAVE"))
            ],
          ),
        ),
      ),
    );
  }

  void saveClient() async {
    final CustomerProvider customerProvider = CustomerProvider();
    Client client = Client(
      id: clientId,
      fname: fnameController.text,
      mname: mnameController.text,
      lname: lnameController.text,
    );

    int clientInfoId = await clientProvider.insertClient(client);
    if (kDebugMode) {
      print('Draft loan saved with ID: $clientInfoId');
    }

    try {
      for (var customer in _customers) {
        await customerProvider.insertCustomer(customer, clientInfoId);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Loan application was successfully saved.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save draft: $e'),
        ),
      );
    }
  }

  void _addCustomers() {
    if (_customers.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You can only add up to 3 customers.')));
      return;
    }
    _showCustomersModal();
  }

  void _editCustomer(int index) {
    _showCustomersModal(index);
  }

  void _showCustomersModal([int? index]) {
    final customer = index != null
        ? _customers[index]
        : Customer(
            cnameController: TextEditingController(),
            goodsController: TextEditingController(),
            contactnoController: TextEditingController(),
            contactnameController: TextEditingController());

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        elevation: 10,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.85,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: CustomTextFormField(
                      hint: "Name of Top Customer",
                      textEditingController: customer.cnameController,
                      icon: Icons.add_home_work_rounded,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: CustomTextFormField(
                      hint: "Goods Purchased/Services Availed",
                      textEditingController: customer.goodsController,
                      icon: Icons.add_home_work_rounded,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: CustomTextFormField(
                      hint: "Contact Person",
                      textEditingController: customer.contactnameController,
                      icon: Icons.add_home_work_rounded,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: CustomTextFormField(
                      hint: "Contact Number",
                      textEditingController: customer.contactnoController,
                      icon: Icons.add_home_work_rounded,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  CustomButton(
                    color: AppColors().kIconColor,
                    titleButton: index == null ? "SAVE" : "UPDATE",
                    onPressed: () {
                      if (index == null) {
                        setState(() {
                          _customers.add(customer);
                        });
                      } else {
                        _customers[index] = customer;
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _removeCustomer(int index) {
    setState(() {
      _customers.removeAt(index);
    });
  }
}
