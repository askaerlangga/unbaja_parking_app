import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class KendaraanTerparkirController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  var searchKeyword = ''.obs;

  var dropdownValue = 'Parkir'.obs;
  List<String> dropdownItems = ['Parkir', 'Masuk', 'Keluar'];

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDataKendaraan(
      String idKendaraaan) {
    var docRef = db.collection('vehicles').doc(idKendaraaan);
    return docRef.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getListKendaraanTerparkir() {
    var timeNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var lastTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 23:59:00').millisecondsSinceEpoch);
    var listKendaraan = db
        .collection('parking')
        .where('active', isEqualTo: true)
        // .where('nomor_plat', isEqualTo: search.text)
        .where('masuk', isLessThan: lastTime)
        .orderBy('masuk', descending: true)
        .snapshots();

    return listKendaraan;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchKendaraanTerparkir() {
    var timeNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var lastTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 23:59:00').millisecondsSinceEpoch);
    var listKendaraan = db
        .collection('parking')
        .where('active', isEqualTo: true)
        .where('nomor_plat', isEqualTo: searchKeyword.value)
        .where('masuk', isLessThan: lastTime)
        .orderBy('masuk', descending: true)
        .snapshots();
    return listKendaraan;
  }
}
