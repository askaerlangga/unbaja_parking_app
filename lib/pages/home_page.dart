import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/routes/page_name.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UNBAJA Parking'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.offAllNamed(PageName.login);
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
