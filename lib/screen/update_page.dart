import 'package:flutter/material.dart';
import 'package:loan_app/provider/client_provider.dart';

import '../models/clients.dart';
import '../models/customer.dart';
import '../utils/custom_button.dart';
import '../utils/custom_textfield.dart';
import '../utils/my_colors.dart';

class UpdateClientPage extends StatefulWidget {
  final Client client;
  final List<Customer> customers;
  const UpdateClientPage(
      {super.key, required this.client, required this.customers});

  @override
  State<UpdateClientPage> createState() => _UpdateClientPageState();
}

class _UpdateClientPageState extends State<UpdateClientPage> {
  late TextEditingController fnameController;
  late TextEditingController mnameController;
  late TextEditingController lnameController;
  late List<Customer> customers;

  @override
  void initState() {
    super.initState();
    fnameController = TextEditingController(text: widget.client.fname);
    mnameController = TextEditingController(text: widget.client.mname);
    lnameController = TextEditingController(text: widget.client.lname);
    customers = widget.customers;
  }

  void _updateClient() async {
    final updatedClient = Client(
        id: widget.client.id,
        fname: fnameController.text,
        mname: mnameController.text,
        lname: lnameController.text);
    await ClientProvider().updateClient(updatedClient);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              onPressed: _updateClient,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _addCustomers() {
    if (customers.length >= 3) {
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
        ? customers[index]
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
                          widget.customers.add(customer);
                        });
                      } else {
                        widget.customers[index] = customer;
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
      widget.customers.removeAt(index);
    });
  }
}
