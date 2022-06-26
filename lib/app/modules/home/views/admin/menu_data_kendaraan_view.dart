import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DataKendaraanView extends GetView {
  const DataKendaraanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataKendaraanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DataKendaraanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
