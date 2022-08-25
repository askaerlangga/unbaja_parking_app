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

  Stream<DocumentSnapshot<Map<String, dynamic>>> getListKendaraan(
      String idKendaraan) {
    var data = db.collection('vehicles').doc(idKendaraan).snapshots();
    return data;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDataKendaraan(
      String idKendaraan) {
    var dataKendaraan = db.collection('vehicles').doc(idKendaraan).snapshots();
    return dataKendaraan;
  }

  void hapusKendaraan(String uid, String idKendaraan) {
    var docRef = db.collection('users').doc(uid);
    var kendaraan = db.collection('vehicles').doc(idKendaraan);

    Get.defaultDialog(
        title: 'Hapus Kendaraan',
        middleText: 'Anda yakin ingin menghapus kendaraan ini?',
        textCancel: 'Batal',
        textConfirm: 'Hapus',
        onConfirm: () async {
          docRef.update({
            'kendaraan': FieldValue.arrayRemove([idKendaraan])
          });
          kendaraan.delete();
          Get.back();
          Get.defaultDialog(
              middleText: 'Kendaraan berhasil dihapus', textCancel: 'Ok');
        });
  }

  void setKendaraanUtama(String uid, String idKendaraan) {
    var docRef = db.collection('users').doc(uid);
    var kendaraanUtama = docRef.get().then((value) {
      var data = (value.data() as Map<String, dynamic>)['kendaraan_utama'];
      return data;
    });
    if (kendaraanUtama != null) {
      docRef.update({'kendaraan_utama': idKendaraan});
    } else {
      docRef.set({'kendaraan_utama': idKendaraan});
    }
  }

  void unsetKendaraanUtama(String uid) {
    var docRef = db.collection('users').doc(uid);
    var kendaraanUtama = docRef.get().then((value) {
      var data = (value.data() as Map<String, dynamic>)['kendaraan_utama'];
      return data;
    });
    if (kendaraanUtama != null) {
      docRef.update({'kendaraan_utama': FieldValue.delete()});
    } else {
      Get.defaultDialog(middleText: 'Belum ada kendaraan Utama');
    }
  }
}
