import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KendaraanTamuController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController merek = TextEditingController();
  TextEditingController nomorPlat = TextEditingController();
  String? dropdownValue;
  List<String> dropdownItems = ['Sepeda Motor', 'Mobil'];
  String? idPetugas;

  void parkirMasuk() {
    if (dropdownValue != null && merek.text != '' && nomorPlat.text != '') {
      db.collection('parking').add({
        'masuk': FieldValue.serverTimestamp(),
        'jenis_kendaraan': dropdownValue,
        'merek': merek.text,
        'nomor_plat': nomorPlat.text,
        'pengendara': 'Tamu',
        'petugas_masuk': idPetugas,
        'active': true
      });
      Get.back();
      Get.defaultDialog(middleText: 'Kendaraan Masuk');
    } else {
      Get.defaultDialog(middleText: 'Semua data harus diisi');
    }
  }
}
