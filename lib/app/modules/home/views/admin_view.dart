import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/home/controllers/home_controller.dart';

class AdminView extends GetView<HomeController> {
  const AdminView({Key? key}) : super(key: key);
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
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
