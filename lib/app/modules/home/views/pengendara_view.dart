import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class PengendaraView extends GetView<HomeController> {
  const PengendaraView({Key? key}) : super(key: key);

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
