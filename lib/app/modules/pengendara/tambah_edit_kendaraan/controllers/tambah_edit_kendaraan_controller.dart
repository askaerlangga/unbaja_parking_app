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

  Future<Map<String, dynamic>> getUserData(String uid) {
    var userData = db.collection('users').doc(uid).get().then((value) {
      var data = value.data() as Map<String, dynamic>;
      return data;
    });
    return userData;
  }

  void tambahKendaraan(
      String uid, String jenisKendaraan, String merek, String nomorPlat) async {
    String? idKendaraan;
    try {
      await db.collection('vehicles').add({
        'jenis_kendaraan': jenisKendaraan,
        'merek_kendaraan': merek,
        'nomor_plat': nomorPlat.toUpperCase(),
        'pemilik': uid
      }).then((value) {
        idKendaraan = value.id;
      });

      var check = db.collection('users').doc(uid).get().then((value) {
        var data = (value.data() as Map<String, dynamic>)['kendaraan'];
        return data;
      });

      if (check != null) {
        db.collection('users').doc(uid).update({
          'kendaraan': FieldValue.arrayUnion([idKendaraan]),
        });
      } else {
        db.collection('users').doc(uid).set({
          'kendaraan': [idKendaraan]
        });
      }
      Get.defaultDialog(
          middleText: 'Berhasil Menambah kendaraan',
          textCancel: 'Ok',
          onCancel: () {
            Get.back();
          });
    } catch (e) {
      print(e);
    }
  }

  void ubahKendaraan(String idKendaraan, String jenisKendaraan, String merek,
      String nomorPlat) async {
    if (dropdownValue != null &&
        this.merek.text != '' &&
        this.nomorPlat.text != '') {
      try {
        await db.collection('vehicles').doc(idKendaraan).update({
          'jenis_kendaraan': jenisKendaraan,
          'merek_kendaraan': merek,
          'nomor_plat': nomorPlat.toUpperCase(),
        });

        Get.defaultDialog(
            middleText: 'Berhasil Mengubah kendaraan',
            textCancel: 'Ok',
            onCancel: () {
              Get.back();
            });
      } catch (e) {
        print(e);
      }
    } else {
      Get.defaultDialog(
          middleText: 'Data tidak boleh kosong!', textCancel: 'Ok');
    }
  }
}
