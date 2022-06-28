import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrcodeScannerController extends GetxController {
  var db = FirebaseFirestore.instance;
  String? idPengendara;
  String? idKendaraan;
  String? idPetugas;

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

  void parkirMasuk() {
    db.collection('parking').add({
      'masuk': FieldValue.serverTimestamp(),
      'kendaraan': idKendaraan,
      'pengendara': idPengendara,
      'petugas': idPetugas
    });
    Get.back();
    Get.defaultDialog(middleText: 'Kendaraan Masuk');
  }
}
