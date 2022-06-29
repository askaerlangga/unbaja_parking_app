import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrcodeScannerController extends GetxController {
  var db = FirebaseFirestore.instance;
  String? idPengendara;
  String? idKendaraan;
  String? idPetugas;

  bool? active;
  String? idParkir;

  MobileScannerController cameraController = MobileScannerController();
  var scanCode = ''.obs;
  TextEditingController nomorPlat = TextEditingController();

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

  void parkirMasuk() {
    db.collection('parking').add({
      'masuk': FieldValue.serverTimestamp(),
      'kendaraan': idKendaraan,
      'pengendara': idPengendara,
      'petugas_masuk': idPetugas,
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
