import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataKendaraanController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  var searchKeyword = ''.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> getListKendaraan() {
    var list = db.collection('vehicles').snapshots();
    return list;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchListKendaraan() {
    var list = db
        .collection('vehicles')
        .where('nomor_plat', isEqualTo: searchKeyword.value)
        .snapshots();
    return list;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataKendaraan(
      String referenceId) async {
    var dataKendaraan = db.collection('vehicles').doc(referenceId).get();
    return dataKendaraan;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataPengendara(
      String referenceId) async {
    var dataPengendara = db.collection('users').doc(referenceId).get();
    return dataPengendara;
  }
}
