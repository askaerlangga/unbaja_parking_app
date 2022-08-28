import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unbaja_parking_app/app/modules/riwayat_kendaraan_parkir/controllers/riwayat_kendaraan_parkir_controller.dart';

import '../../petugas/qrcode_scanner/widgets/container_detail_pengendara_widget.dart';

class DetailRiwayatKendaraanParkirView
    extends GetView<RiwayatKendaraanParkirController> {
  const DetailRiwayatKendaraanParkirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Riwayat Parkir'),
          centerTitle: true,
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: controller.getDataParkir(Get.arguments[0]),
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.data?.data() != null) {
              var dataParkir = snapshot.data!.data();
              print(dataParkir);
              var jamMasuk = (dataParkir?['masuk'] as Timestamp).toDate();
              var jamKeluar = (dataParkir?['keluar'] as Timestamp).toDate();
              var durasi = jamKeluar
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
                    title: 'Jenis : ',
                    middleText: dataParkir['jenis'],
                  ),
                  ContainerDetailPengendara(
                    title: 'Merek : ',
                    middleText: dataParkir['merek'],
                  ),
                  ContainerDetailPengendara(
                    title: 'Model : ',
                    middleText: dataParkir['model'],
                  ),
                  ContainerDetailPengendara(
                    title: 'Warna : ',
                    middleText: dataParkir['warna'],
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
                    title: 'Lokasi : ',
                    middleText: dataParkir['lokasi'],
                  ),
                  ContainerDetailPengendara(
                    title: 'Keluar : ',
                    middleText:
                        DateFormat('dd-MM-yyyy, HH:mm').format(jamKeluar),
                  ),
                  ContainerDetailPengendara(
                      title: 'Petugas Keluar :',
                      middleText: dataParkir['petugas_keluar']),
                  ContainerDetailPengendara(
                    title: 'Lama Parkir : ',
                    middleText: '${durasi[0]} Jam, ${durasi[1]} Menit',
                  ),
                ],
              );
            }
            return const Text('Tidak ada data');
          },
        ));
  }
}
