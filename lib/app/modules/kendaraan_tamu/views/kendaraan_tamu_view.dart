import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';

import '../controllers/kendaraan_tamu_controller.dart';

class KendaraanTamuView extends GetView<KendaraanTamuController> {
  const KendaraanTamuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.idPetugas = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kendaraan Umum / Tamu'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomButton(
                icon: Icons.login,
                label: 'Kendaraan Masuk',
                onPressed: () {
                  Get.toNamed(Routes.KENDARAAN_TAMU_MASUK);
                }),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                icon: Icons.logout, label: 'Kendaraan Keluar', onPressed: () {})
          ]),
        ),
      ),
    );
  }
}
