import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatKendaraanParkirController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  var searchKeyword = ''.obs;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDataKendaraan(
      String idKendaraaan) {
    var docRef = db.collection('vehicles').doc(idKendaraaan);
    return docRef.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getListParkir() {
    var timeNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var firstTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 00:00:00').millisecondsSinceEpoch);
    var lastTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 23:59:00').millisecondsSinceEpoch);
    var listKendaraan = db
        .collection('parking')
        .where('active', isEqualTo: false)
        .where('keluar', isLessThan: lastTime)
        .where('keluar', isGreaterThan: firstTime)
        .orderBy('keluar', descending: true)
        .snapshots();

    return listKendaraan;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchParkir() {
    var timeNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var firstTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 00:00:00').millisecondsSinceEpoch);
    var lastTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 23:59:00').millisecondsSinceEpoch);
    var listKendaraan = db
        .collection('parking')
        .where('active', isEqualTo: false)
        .where('nomor_plat', isEqualTo: searchKeyword.value)
        .where('keluar', isLessThan: lastTime)
        .where('keluar', isGreaterThan: firstTime)
        .orderBy('keluar', descending: true)
        .snapshots();
    return listKendaraan;
  }
}
