import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';
import 'package:unbaja_parking_app/app/widgets/custom_textfield.dart';

import '../controllers/tambah_akun_controller.dart';

class TambahAkunView extends GetView<TambahAkunController> {
  const TambahAkunView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Akun'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CustomTextField(controller: controller.email, labelText: 'Email'),
          CustomTextField(
            controller: controller.password,
            labelText: 'Password',
            obsecureText: true,
          ),
          CustomTextField(controller: controller.nama, labelText: 'Nama'),
          CustomTextField(controller: controller.alamat, labelText: 'Alamat'),
          CustomTextField(
            controller: controller.nomorTelepon,
            labelText: 'Nomor Telepon',
            keyboardType: TextInputType.number,
          ),
          CustomTextField(
            controller: controller.nomorIdentitas,
            labelText: 'NIDN/Nomor Induk Pegawai',
            keyboardType: TextInputType.number,
            // enable: (Get.arguments[2] == null) ? true : false,
          ),
          SizedBox(
            width: Get.width,
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                  // hint: const Text('Status'),
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  value: controller.dropdownValue,
                  items: controller.dropdownItems
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? value) {
                    controller.dropdownValue = value!;
                    print(controller.dropdownValue);
                  }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              label: 'SELESAI',
              onPressed: () {
                controller.tambahAkun(
                  controller.email.text,
                  controller.password.text,
                  controller.nama.text,
                  controller.alamat.text,
                  controller.nomorTelepon.text,
                  controller.nomorIdentitas.text,
                  controller.dropdownValue.toString(),
                  Get.arguments,
                );
              })
        ],
      ),
    );
  }
}
