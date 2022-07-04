import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataPengendaraController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  var searchKeyword = ''.obs;

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
}
