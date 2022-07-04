import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';
import 'package:unbaja_parking_app/app/widgets/menu_button.dart';

class MenuDataPenggunaView extends GetView {
  const MenuDataPenggunaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Pengguna'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            MenuButton(
                label: 'Data Pengendara',
                icon: Icons.person,
                onPressed: () {
                  Get.toNamed(Routes.DATA_PENGENDARA);
                }),
            MenuButton(
                label: 'Data Petugas', icon: Icons.person, onPressed: () {}),
            MenuButton(
                label: 'Data Admin',
                icon: Icons.admin_panel_settings,
                onPressed: () {}),
          ],
        ));
  }
}
