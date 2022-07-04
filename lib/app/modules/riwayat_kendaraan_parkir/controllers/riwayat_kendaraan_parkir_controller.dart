import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatKendaraanParkirController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  var searchKeyword = ''.obs;
  var selectedDay = DateTime.now().obs;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDataKendaraan(
      String idKendaraaan) {
    var docRef = db.collection('vehicles').doc(idKendaraaan);
    return docRef.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getListParkir() {
    var timeNow = DateFormat('yyyy-MM-dd').format(selectedDay.value);
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
    var timeNow = DateFormat('yyyy-MM-dd').format(selectedDay.value);
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

  Future<QuerySnapshot<Map<String, dynamic>>> getDateRange() {
    var list = db.collection('parking').orderBy('keluar').get();
    return list;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataParkir(
      String idParkir) {
    var parkir = db.collection('parking').doc(idParkir).get();
    return parkir;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataPetugas(
      String idPetugas) {
    var dataPetugas = db.collection('users').doc(idPetugas);
    return dataPetugas.get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataPengendara(String uid) {
    var dataPengendara = db.collection('users').doc(uid);
    return dataPengendara.get();
  }
}
