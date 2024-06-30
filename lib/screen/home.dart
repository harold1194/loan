import 'package:flutter/material.dart';
import 'package:loan_app/screen/encode.dart';
import 'package:loan_app/screen/view_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EncodePage()));
            },
            child: const Center(
              child: Icon(
                Icons.person_add,
                size: 50,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ViewPage()));
            },
            child: const Center(
              child: Icon(
                Icons.file_present,
                size: 50,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
