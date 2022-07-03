import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/kendaraan_tamu/controllers/kendaraan_tamu_controller.dart';
import 'package:unbaja_parking_app/app/modules/petugas/qrcode_scanner/container_detail_pengendara_widget.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';

class KendaraanTamuKeluarDetailView extends GetView<KendaraanTamuController> {
  const KendaraanTamuKeluarDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kendaraan Keluar'),
          centerTitle: true,
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: controller.getDataParkir(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              var dataParkir = snapshot.data!.data();
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  ContainerDetailPengendara(
                    title: 'Nomor Plat Kendaraan : ',
                    middleText: dataParkir!['nomor_plat'],
                  ),
                  ContainerDetailPengendara(
                    title: 'Jenis Kendaraan : ',
                    middleText: dataParkir['jenis_kendaraan'],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      label: 'PROSES',
                      onPressed: () {
                        controller.parkirKeluar(Get.arguments);
                      })
                ],
              );
            }
            return const Text('Tidak ada data');
          },
        ));
  }
}
