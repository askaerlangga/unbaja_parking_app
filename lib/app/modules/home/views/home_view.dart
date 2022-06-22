import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/controllers/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UNBAJA Parking'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.logout();
                // Get.offAllNamed(PageName.login);
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
