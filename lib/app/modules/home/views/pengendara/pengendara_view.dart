import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/controllers/auth_controller.dart';
import 'package:unbaja_parking_app/app/modules/home/controllers/home_controller.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';
import 'package:unbaja_parking_app/app/widgets/menu_button.dart';
import 'package:unbaja_parking_app/app/widgets/user_info_panel.dart';

class PengendaraView extends GetView<HomeController> {
  const PengendaraView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var auth = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('UNBAJA Parking'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.getUserData(controller.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.data!.data() != null) {
              var userData = snapshot.data!.data() as Map<String, dynamic>;
              if (userData['nama'] != null) {
                return ListView(
                  children: [
                    UserInfoPanel(
                      nameUser: userData['nama'],
                      levelUser: userData['level'],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Column(
                        children: <Widget>[
                          MenuButton(
                              label: 'Tampil QR Code',
                              icon: Icons.qr_code,
                              onPressed: () {
                                Get.toNamed(Routes.PENAMPIL_QRCODE,
                                    arguments: auth.uid.value);
                              }),
                          MenuButton(
                              label: 'Kendaraan Saya',
                              icon: Icons.directions_car,
                              onPressed: () {
                                Get.toNamed(Routes.KENDARAAN_SAYA,
                                    arguments: auth.uid.value);
                              }),
                          MenuButton(
                              label: 'Pengaturan Profil',
                              icon: Icons.person,
                              onPressed: () {
                                Get.toNamed(Routes.PENGATURAN_PROFIL,
                                    arguments: 'Pengaturan Profil');
                              }),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Selamat Datang',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Anda diharuskan mengisi beberapa informasi sebelum menggunakan aplikasi ini',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          label: 'LANJUTKAN',
                          onPressed: () {
                            Get.toNamed(Routes.EDIT_DATA_PENGENDARA,
                                arguments: [
                                  'ISI DATA PENGGUNA',
                                  controller.uid,
                                  null
                                ]);
                          }),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
