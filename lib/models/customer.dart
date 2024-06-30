import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Customer {
  int? id;
  int? clientid;
  TextEditingController cnameController = TextEditingController();
  TextEditingController goodsController = TextEditingController();
  TextEditingController contactnoController = TextEditingController();
  TextEditingController contactnameController = TextEditingController();

  Customer(
      {this.id,
      this.clientid,
      required this.cnameController,
      required this.contactnameController,
      required this.contactnoController,
      required this.goodsController});

  Customer.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int?;
      clientid = json['clientid'] as int;
      cnameController.text = json['cname']?.toString() ?? '';
      goodsController.text = json['goods']?.toString() ?? '';
      contactnoController.text = json['contactnoController']?.toString() ?? '';
      contactnameController.text =
          json['contactnameController']?.toString() ?? '';
    } catch (e) {
      if (kDebugMode) {
        print("Error creating customer from JSON: $e");
        print("Problematic Json data: $json");
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clientid'] = clientid;
    data['cname'] = cnameController.text; // Serialize the text
    data['goods'] = goodsController.text; // Serialize the text
    data['contactno'] = contactnoController.text; // Serialize the text
    data['contactname'] = contactnameController.text; // Serialize the text
    return data;
  }
}
