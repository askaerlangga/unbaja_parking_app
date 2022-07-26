import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataPetugasController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  var searchKeyword = ''.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> getListPetugas() {
    var list =
        db.collection('users').where('level', isEqualTo: 'petugas').snapshots();
    return list;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchListPetugas() {
    var list = db
        .collection('users')
        .where('level', isEqualTo: 'petugas')
        .where('nama', isEqualTo: searchKeyword.value)
        .snapshots();
    return list;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataPetugas(
      String referenceId) async {
    var dataPetugas = db.collection('users').doc(referenceId).get();
    return dataPetugas;
  }
}
