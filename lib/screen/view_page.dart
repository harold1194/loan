import 'package:flutter/material.dart';
import 'package:loan_app/models/customer.dart';
import 'package:loan_app/provider/client_provider.dart';
import 'package:loan_app/provider/customer_provider.dart';
import 'package:loan_app/screen/update_page.dart';

import '../models/clients.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  late Future<List<Client>> _client;
  void _showClientList() async {
    setState(() {
      _client = ClientProvider().getAllClients();
    });
  }

  @override
  void initState() {
    super.initState();
    _showClientList();
  }

  Future<void> navigateToUpdatePage(
      Client client, List<Customer> customers) async {
    final result = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateClientPage(
                  client: client,
                  customers: customers,
                )));
    if (result == true) {
      _showClientList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: FutureBuilder<List<Client>>(
            future: _client,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: snapshot.data!.map((_client) {
                    return Column(
                      children: snapshot.data!.map((_client) {
                        return FutureBuilder<List<Customer>>(
                            future: CustomerProvider()
                                .getCustomerByCustomerId(_client.id!),
                            builder: (context, customerSnapshot) {
                              if (customerSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (customerSnapshot.hasError) {
                                return Text('Error: ${customerSnapshot.error}');
                              } else {
                                return Center(
                                  child: Container(
                                    height: 100,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      children: [
                                        Text(
                                            "${_client.fname} ${_client.mname} ${_client.lname}"),
                                        ElevatedButton(
                                          onPressed: () {
                                            navigateToUpdatePage(_client,
                                                customerSnapshot.data!);
                                          },
                                          child: const Text('Update'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            });
                      }).toList(),
                    );
                  }).toList(),
                );
              }
            }),
      )),
    );
  }
}
