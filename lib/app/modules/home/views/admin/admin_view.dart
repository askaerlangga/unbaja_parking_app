import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/home/controllers/home_controller.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';
import 'package:unbaja_parking_app/app/widgets/admin_indikator.dart';
import 'package:unbaja_parking_app/app/widgets/menu_button.dart';
import 'package:unbaja_parking_app/app/widgets/user_info_panel.dart';

class AdminView extends GetView<HomeController> {
  const AdminView({Key? key}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'INDIKATOR',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.getJumlahPengguna(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active &&
                        snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      print(snapshot.data!.docs.length);
                      return AdminIndikator(
                          flex: 0,
                          icon: Icons.person,
                          label: ' Jumlah Pengguna',
                          middleText: '${snapshot.data!.docs.length}',
                          color: Colors.blue);
                    }
                    return const AdminIndikator(
                        flex: 0,
                        icon: Icons.person,
                        label: ' Jumlah Pengguna',
                        middleText: '0',
                        color: Colors.blue);
                  }),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.getJumlahKendaraan(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active &&
                        snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      print(snapshot.data!.docs.length);
                      return AdminIndikator(
                          flex: 0,
                          icon: Icons.directions_car,
                          label: ' Jumlah Kendaraan',
                          middleText: '${snapshot.data!.docs.length}',
                          color: Colors.blue);
                    }
                    return const AdminIndikator(
                        flex: 0,
                        icon: Icons.directions_car,
                        label: ' Jumlah Kendaraan',
                        middleText: '0',
                        color: Colors.blue);
                  }),
              const SizedBox(height: 10),
              const Text(
                'TOMBOL MENU',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              MenuButton(
                  label: 'Data Pengguna',
                  icon: Icons.person,
                  onPressed: () {
                    Get.toNamed(Routes.MENU_DATA_PENGGUNA);
                  }),
              MenuButton(
                  label: 'Data Kendaraan',
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
                  }),
              MenuButton(
                  label: 'Laporan',
                  icon: Icons.print,
                  onPressed: () {
                    Get.toNamed(Routes.LAPORAN);
                  }),
            ],
          ),
        ),
      ]),
    );
  }
}
