import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class KendaraanTerparkirController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  var searchKeyword = ''.obs;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDataKendaraan(
      String idKendaraaan) {
    var docRef = db.collection('vehicles').doc(idKendaraaan);
    return docRef.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getListKendaraanTerparkir() {
    var listKendaraan = db
        .collection('parking')
        .where('active', isEqualTo: true)
        .orderBy('masuk', descending: true)
        .snapshots();

    return listKendaraan;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchKendaraanTerparkir() {
    var listKendaraan = db
        .collection('parking')
        .where('active', isEqualTo: true)
        .where('nomor_plat', isEqualTo: searchKeyword.value)
        .orderBy('masuk', descending: true)
        .snapshots();
    return listKendaraan;
  }
}
