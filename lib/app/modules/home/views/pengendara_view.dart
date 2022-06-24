import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/home/controllers/home_controller.dart';
import 'package:unbaja_parking_app/app/modules/home/views/widgets/menu_button.dart';
import 'package:unbaja_parking_app/app/modules/home/views/widgets/user_info_panel.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

class PengendaraView extends GetView<HomeController> {
  const PengendaraView({Key? key}) : super(key: key);
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
              MenuButton(
                  label: 'Tampil QR Code',
                  icon: Icons.qr_code,
                  onPressed: () {
                    Get.toNamed(Routes.PENAMPIL_QRCODE);
                  }),
              MenuButton(
                  label: 'Kendaraan Saya',
                  icon: Icons.directions_car,
                  onPressed: () {}),
              MenuButton(
                  label: 'Pengaturan Profil',
                  icon: Icons.person,
                  onPressed: () {}),
            ],
          ),
        ),
      ]),
    );
  }
}
