import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/models/pengguna.dart';

class DataPengendaraController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  var searchKeyword = ''.obs;

  var pengguna = Pengguna();

  Stream<QuerySnapshot<Map<String, dynamic>>> getListPengendara() {
    var list = db
        .collection('users')
        .where('level', isEqualTo: 'pengendara')
        .snapshots();
    return list;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchListPengendara() {
    var list = db
        .collection('users')
        .where('level', isEqualTo: 'pengendara')
        .where('nama', isEqualTo: searchKeyword.value)
        .snapshots();
    return list;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataPengendara(
      String referenceId) async {
    var dataPengendara = db.collection('users').doc(referenceId).get();
    return dataPengendara;
  }
}
