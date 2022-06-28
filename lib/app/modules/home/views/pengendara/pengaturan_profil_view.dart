import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/home/controllers/home_controller.dart';
import 'package:unbaja_parking_app/app/modules/home/widgets/container_pengaturan_profil.dart';
import 'package:unbaja_parking_app/app/modules/petugas/qrcode_scanner/container_detail_pengendara_widget.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';

class PengaturanProfilView extends GetView<HomeController> {
  const PengaturanProfilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.getUserData(controller.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data != null) {
                  var userData = snapshot.data!.data() as Map<String, dynamic>;
                  return ListView(
                    padding: const EdgeInsets.all(15),
                    children: [
                      const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Data Pengguna',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ContainerDetailPengendara(
                                  title: 'Nama', middleText: userData['nama']),
                              ContainerDetailPengendara(
                                  title: 'Alamat',
                                  middleText: userData['alamat']),
                              ContainerDetailPengendara(
                                  title: 'Nomor Telepon',
                                  middleText: userData['nomor_telepon']),
                              ContainerDetailPengendara(
                                  title: (userData['status'] == 'Mahasiswa')
                                      ? 'NPM'
                                      : (userData['status'] == 'Dosen')
                                          ? 'NIDN'
                                          : 'Nomor Induk',
                                  middleText: userData['nomor_identitas']),
                              ContainerDetailPengendara(
                                  title: 'Status',
                                  middleText: userData['status'])
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          label: 'Ubah Data Pengguna',
                          onPressed: () {
                            Get.toNamed(Routes.EDIT_DATA_PENGENDARA,
                                arguments: [
                                  'Ubah Data Pengguna',
                                  controller.uid,
                                  userData['nama'],
                                  userData['alamat'],
                                  userData['nomor_telepon'],
                                  userData['nomor_identitas'],
                                  userData['status']
                                ]);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          label: 'Ubah Password',
                          onPressed: () {
                            Get.toNamed(Routes.UBAH_PASSWORD_PENGENDARA);
                          }),
                    ],
                  );
                }
                return const Center(
                  child: Text('Tidak ada data'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
