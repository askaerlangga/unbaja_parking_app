import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

class QrcodeScannerController extends GetxController {
  var db = FirebaseFirestore.instance;
  String? idPengendara;
  String? idKendaraan;
  String? idPetugas;
  String? idParkir;
  String? nomorPlat;

  MobileScannerController cameraController = MobileScannerController();
  var scanCode = ''.obs;
  TextEditingController nomorPlatController = TextEditingController();

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataKendaraan(
      String idKendaraan) {
    var dataKendaraan = db.collection('vehicles').doc(idKendaraan);
    return dataKendaraan.get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataPengendara(String uid) {
    var dataPengendara = db.collection('users').doc(uid);
    return dataPengendara.get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDataParkir(
      String idKendaraan) {
    var dataParkir = db.collection('parking');
    return dataParkir
        .where('kendaraan', isEqualTo: idKendaraan)
        .where('active', isEqualTo: true)
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataPetugas(
      String idPetugas) {
    var dataPetugas = db.collection('users').doc(idPetugas);
    return dataPetugas.get();
  }

  void cariManual(var argument) {
    db
        .collection('vehicles')
        .where('nomor_plat', isEqualTo: nomorPlatController.text.toUpperCase())
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        var data = value.docs[0].reference.id;
        Get.toNamed(Routes.SCANNER_DETAIL_PENGENDARA,
            arguments: [data, argument]);
      } else {
        Get.defaultDialog(middleText: 'Kendaraan tidak terdaftar');
      }
    });
  }

  void parkirMasuk() {
    db.collection('parking').add({
      'masuk': FieldValue.serverTimestamp(),
      'kendaraan': idKendaraan,
      'pengendara': idPengendara,
      'petugas_masuk': idPetugas,
      'nomor_plat': nomorPlat,
      'active': true
    });
    Get.back();
    Get.defaultDialog(middleText: 'Kendaraan Masuk');
  }

  void parkirKeluar(String idParkir) {
    db.collection('parking').doc(idParkir).update({
      'keluar': FieldValue.serverTimestamp(),
      'petugas_keluar': idPetugas,
      'active': false
    });
    Get.back();
    Get.defaultDialog(middleText: 'Kendaraan Keluar');
  }
}
