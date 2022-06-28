import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';
import 'package:unbaja_parking_app/app/widgets/custom_textfield.dart';

import '../controllers/ubah_password_pengendara_controller.dart';

class UbahPasswordPengendaraView
    extends GetView<UbahPasswordPengendaraController> {
  const UbahPasswordPengendaraView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('UbahPasswordPengendaraView'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            CustomTextField(
                controller: controller.passwordLama,
                labelText: 'Password Lama'),
            CustomTextField(
                controller: controller.passwordBaru,
                labelText: 'Password Baru'),
            CustomTextField(
                controller: controller.passwordBaruConfirm,
                labelText: 'Konfirmasi Password baru'),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                label: 'Ubah Password',
                onPressed: () {
                  controller.ubahPassword(controller.passwordBaruConfirm.text,
                      controller.passwordLama.text);
                })
          ],
        ));
  }
}
