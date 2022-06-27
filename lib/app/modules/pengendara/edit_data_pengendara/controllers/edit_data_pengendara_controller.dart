import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditDataPengendaraController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController nomorTelepon = TextEditingController();
  TextEditingController nomorIdentitas = TextEditingController();
  TextEditingController status = TextEditingController();

  void editDataPengendara(String uid, String nama, String alamat,
      String nomorTelepon, String nomorIdentitas, String status) {
    Get.defaultDialog(
        title: 'Ubah Data',
        middleText: 'Apakah anda yakin ingin mengubah data?',
        textCancel: 'Batal',
        textConfirm: 'Ubah',
        confirmTextColor: Colors.white,
        onConfirm: () {
          try {
            var docRef = db.collection('users').doc(uid);
            docRef.update({
              'nama': nama,
              'alamat': alamat,
              'nomor_telepon': nomorTelepon,
              'nomor_identitas': nomorIdentitas,
              'status': status
            });
            Get.back();
            Get.defaultDialog(
                title: 'Ubah Data',
                middleText: 'Berhasil mengubah data pengguna',
                textCancel: 'Ok',
                onCancel: () {
                  Get.back();
                });
          } catch (e) {
            print(e);
            Get.defaultDialog(middleText: 'Ubah data gagal');
          }
        },
        onCancel: () {
          Get.back();
        });
  }
}
