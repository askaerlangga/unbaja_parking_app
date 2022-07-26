import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/models/pengguna.dart';

class DataAdminController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  var searchKeyword = ''.obs;

  var pengguna = Pengguna();

  Stream<QuerySnapshot<Map<String, dynamic>>> getListAdmin() {
    var list =
        db.collection('users').where('level', isEqualTo: 'admin').snapshots();
    return list;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchListAdmin() {
    var list = db
        .collection('users')
        .where('level', isEqualTo: 'admin')
        .where('nama', isEqualTo: searchKeyword.value)
        .snapshots();
    return list;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataAdmin(
      String referenceId) async {
    var dataPengendara = db.collection('users').doc(referenceId).get();
    return dataPengendara;
  }
}
