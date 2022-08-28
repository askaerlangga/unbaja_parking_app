import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TambahEditKendaraanController extends GetxController {
  final db = FirebaseFirestore.instance;

  TextEditingController warna = TextEditingController();
  TextEditingController nomorPlat = TextEditingController();
  TextEditingController modelLainnya = TextEditingController();

  var jenisKendaraanValue = ''.obs;
  List<String> jenisKendaraanItems = ['Sepeda Motor', 'Mobil'];

  var merekKendaraanActive = false.obs;
  var merekKendaraanValue = ''.obs;
  var merekKendaraanItems = {}.obs;

  Map<String, dynamic> dataMotor = {};
  Map<String, dynamic> dataMobil = {};

  var modelValue = ''.obs;
  var modelItems = [].obs;

  Future<QuerySnapshot<Map<String, dynamic>>> getJenisKendaraan() {
    var jenisKendaraan = db.collection('jenis-kendaraan').get();
    return jenisKendaraan;
  }

  Future<Map<String, dynamic>> getUserData(String uid) {
    var userData = db.collection('users').doc(uid).get().then((value) {
      var data = value.data() as Map<String, dynamic>;
      return data;
    });
    return userData;
  }

  void tambahKendaraan(String uid, String jenis, String merek, String model,
      String warna, String nomorPlat) async {
    String? idKendaraan;
    try {
      await db.collection('vehicles').add({
        'jenis': jenis,
        'merek': merek,
        'model': model,
        'warna': warna,
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
    if (jenisKendaraanValue != null &&
        this.merekKendaraanValue.value != '' &&
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
