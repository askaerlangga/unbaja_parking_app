import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/controllers/auth_controller.dart';
import 'package:unbaja_parking_app/routes/page_name.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UNBAJA Parking'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                authController.logout();
                // Get.offAllNamed(PageName.login);
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
