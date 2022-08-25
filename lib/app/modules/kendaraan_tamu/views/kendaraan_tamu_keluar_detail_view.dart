import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unbaja_parking_app/app/modules/kendaraan_tamu/controllers/kendaraan_tamu_controller.dart';
import 'package:unbaja_parking_app/app/modules/petugas/qrcode_scanner/widgets/container_detail_pengendara_widget.dart';
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
              var jamMasuk = (dataParkir?['masuk'] as Timestamp).toDate();
              var durasi = DateTime.now()
                  .difference(jamMasuk)
                  .toString()
                  .split('.')[0]
                  .split(':');
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
                  ContainerDetailPengendara(
                    title: 'Merek Kendaraan : ',
                    middleText: dataParkir['merek_kendaraan'],
                  ),
                  ContainerDetailPengendara(
                    title: 'Nama Pengendara : ',
                    middleText: dataParkir['nama_pengendara'],
                  ),
                  ContainerDetailPengendara(
                    title: 'Masuk : ',
                    middleText:
                        DateFormat('dd-MM-yyyy, HH:mm').format(jamMasuk),
                  ),
                  ContainerDetailPengendara(
                      title: 'Petugas Masuk :',
                      middleText: dataParkir['petugas_masuk']),
                  ContainerDetailPengendara(
                    title: 'Lama Parkir : ',
                    middleText: '${durasi[0]} Jam, ${durasi[1]} Menit',
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
