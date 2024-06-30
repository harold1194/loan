import 'dart:developer';

class Client {
  int? id;
  String? fname;
  String? lname;
  String? mname;

  Client({
    this.id,
    this.fname,
    this.lname,
    this.mname,
  });

  Client.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int;
      fname = json['fname'];
      mname = json['mname'];
      lname = json['lname'];
    } catch (e) {
      log("Error creating Drafting from JSON: $e");
      log("Problematic JSON data: $json");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fname'] = fname;
    data['mname'] = mname;
    data['lname'] = lname;
    return data;
  }
}
