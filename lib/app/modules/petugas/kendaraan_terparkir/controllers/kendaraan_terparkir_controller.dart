import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class KendaraanTerparkirController extends GetxController {
  final db = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDataKendaraan(
      String idKendaraaan) {
    var docRef = db.collection('vehicles').doc(idKendaraaan);
    return docRef.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getListKendaraanTerparkir() {
    var timeNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var firstTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 00:00:00').millisecondsSinceEpoch);
    var lastTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 23:59:00').millisecondsSinceEpoch);
    var listKendaraan = db
        .collection('parking')
        .where('active', isEqualTo: true)
        .where('masuk', isLessThan: lastTime)
        .where('masuk', isGreaterThan: firstTime)
        .orderBy('masuk', descending: true)
        .snapshots();
    return listKendaraan;
  }
}