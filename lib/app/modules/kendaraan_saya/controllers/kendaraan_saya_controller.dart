import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class KendaraanSayaController extends GetxController {
  final db = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) {
    var userData = db.collection('users').doc(uid).snapshots();
    return userData;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getListKendaraan(
      String idKendaraan) {
    var data = db.collection('vehicles').doc(idKendaraan).get();
    return data;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDataKendaraan(
      String idKendaraan) {
    var dataKendaraan = db.collection('vehicles').doc(idKendaraan).snapshots();
    return dataKendaraan;
  }
}
