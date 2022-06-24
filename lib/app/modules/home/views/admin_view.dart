import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/home/controllers/home_controller.dart';
import 'package:unbaja_parking_app/app/modules/home/views/widgets/menu_button.dart';
import 'package:unbaja_parking_app/app/modules/home/views/widgets/user_info_panel.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

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
            children: <Widget>[
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
              // MenuButton(
              //     label: 'Kendaraan Terparkir',
              //     icon: Icons.local_parking,
              //     onPressed: () {}),
              MenuButton(label: 'Laporan', icon: Icons.print, onPressed: () {}),
            ],
          ),
        ),
      ]),
    );
  }
}
