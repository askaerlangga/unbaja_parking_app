import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class KendaraanSayaController extends GetxController {
  final db = FirebaseFirestore.instance;
  var uid;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) {
    var userData = db.collection('users').doc(uid).snapshots();
    return userData;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getListKendaraan(
      String idKendaraan) {
    var data = db.collection('vehicles').doc(idKendaraan).get();
    return data;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDataKendaraan(
      String idKendaraan) {
    var dataKendaraan = db.collection('vehicles').doc(idKendaraan).snapshots();
    return dataKendaraan;
  }

  void hapusKendaraan(String uid, String idKendaraan) {
    var userData = db.collection('users').doc(uid);
    userData.update({
      'kendaraan': FieldValue.arrayRemove([idKendaraan])
    });
  }

  void setKendaraanUtama(String uid, String idKendaraan) {
    var docRef = db.collection('users').doc(uid);
    var kendaraan = docRef.get().then((value) {
      var data = (value.data() as Map<String, dynamic>)['kendaraan_utama'];
      return data;
    });
    if (kendaraan != null) {
      docRef.update({'kendaraan_utama': idKendaraan});
    } else {
      docRef.set({'kendaraan_utama': idKendaraan});
    }
  }
}
