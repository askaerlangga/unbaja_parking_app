import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/kendaraan_tamu/controllers/kendaraan_tamu_controller.dart';
import 'package:unbaja_parking_app/app/modules/petugas/qrcode_scanner/widgets/container_detail_pengendara_widget.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';
import 'package:unbaja_parking_app/app/widgets/custom_textfield.dart';

class KendaraanTamuKeluarView extends GetView<KendaraanTamuController> {
  const KendaraanTamuKeluarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kendaraan Keluar'),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
                textCapitalization: TextCapitalization.characters,
                controller: controller.nomorPlat,
                labelText: 'Nomor Plat Kendaraan'),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                label: 'CARI KENDARAAN',
                onPressed: () {
                  controller.cariKendaraan();
                }),
          ],
        ),
      )),
    );
  }
}
