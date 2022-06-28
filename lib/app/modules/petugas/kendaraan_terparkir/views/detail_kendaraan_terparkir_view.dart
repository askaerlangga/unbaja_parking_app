import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/petugas/kendaraan_terparkir/controllers/kendaraan_terparkir_controller.dart';

class DetailKendaraanTerparkirView
    extends GetView<KendaraanTerparkirController> {
  const DetailKendaraanTerparkirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailKendaraanTerparkirView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailKendaraanTerparkirView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
