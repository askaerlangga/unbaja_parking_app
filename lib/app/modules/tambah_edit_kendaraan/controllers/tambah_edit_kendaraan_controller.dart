import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TambahEditKendaraanController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController merek = TextEditingController();
  TextEditingController nomorPlat = TextEditingController();
  String? dropdownValue;
  List<String> dropdownItems = ['Sepeda Motor', 'Mobil'];

  void tambahKendaraan(
      String uid, String jenisKendaraan, String merek, String nomorPlat) async {
    String? idKendaraan;
    try {
      await db.collection('vehicles').add({
        'jenis_kendaraan': jenisKendaraan,
        'merek_kendaraan': merek,
        'nomor_plat': nomorPlat.toUpperCase()
      }).then((value) {
        idKendaraan = value.id;
      });

      db.collection('users').doc(uid).update({
        'kendaraan': FieldValue.arrayUnion([idKendaraan]),
      });
    } catch (e) {
      print(e);
    }
  }
}
