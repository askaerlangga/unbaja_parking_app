import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/home/controllers/home_controller.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';
import 'package:unbaja_parking_app/app/widgets/menu_button.dart';
import 'package:unbaja_parking_app/app/widgets/parkir_indikator.dart';
import 'package:unbaja_parking_app/app/widgets/user_info_panel.dart';

class PetugasView extends GetView<HomeController> {
  const PetugasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
      body: ListView(children: <Widget>[
        UserInfoPanel(
          nameUser: controller.nameUser.value,
          levelUser: controller.levelUser.value,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: <Widget>[
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.getKendaraanTerparkir(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active &&
                        snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      print(snapshot.data!.docs.length);
                      return ParkirIndikator(
                          flex: 0,
                          icon: Icons.local_parking,
                          label: ' Sedang Parkir',
                          middleText: '${snapshot.data!.docs.length}',
                          color: Colors.blue);
                    }
                    return const ParkirIndikator(
                        flex: 0,
                        icon: Icons.local_parking,
                        label: ' Sedang Parkir',
                        middleText: '0',
                        color: Colors.blue);
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.getKendaraanMasuk(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.active &&
                            snapshot.data != null &&
                            snapshot.data!.docs.isNotEmpty) {
                          print(snapshot.data!.docs.length);
                          return ParkirIndikator(
                              icon: Icons.login,
                              label: 'Masuk',
                              middleText: '${snapshot.data!.docs.length}',
                              color: Colors.green);
                        }
                        return const ParkirIndikator(
                            icon: Icons.login,
                            label: 'Masuk',
                            middleText: '0',
                            color: Colors.green);
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.getKendaraanKeluar(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.active &&
                            snapshot.data != null &&
                            snapshot.data!.docs.isNotEmpty) {
                          print(snapshot.data!.docs.length);
                          return ParkirIndikator(
                              icon: Icons.logout,
                              label: 'Keluar',
                              middleText: '${snapshot.data!.docs.length}',
                              color: Colors.red);
                        }
                        return const ParkirIndikator(
                            icon: Icons.logout,
                            label: 'Keluar',
                            middleText: '0',
                            color: Colors.red);
                      }),
                ],
              ),
              const SizedBox(height: 10),
              MenuButton(
                  label: 'QR Code Scanner',
                  icon: Icons.qr_code,
                  onPressed: () {
                    Get.toNamed(Routes.QRCODE_SCANNER,
                        arguments: controller.uid);
                  }),
              MenuButton(
                  label: 'Pengendara Umum / Tamu',
                  icon: Icons.directions_car,
                  onPressed: () {}),
              MenuButton(
                  label: 'Kendaraan Terparkir',
                  icon: Icons.local_parking,
                  onPressed: () {
                    Get.toNamed(Routes.KENDARAAN_TERPARKIR);
                  }),
              MenuButton(
                  label: 'Riwayat Parkir',
                  icon: Icons.history,
                  onPressed: () {
                    Get.toNamed(Routes.RIWAYAT_KENDARAAN_PARKIR);
                  })
            ],
          ),
        ),
      ]),
    );
  }
}
