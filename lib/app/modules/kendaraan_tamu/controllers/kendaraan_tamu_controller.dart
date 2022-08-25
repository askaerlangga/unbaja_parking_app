import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/models/parkir.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

class KendaraanTamuController extends GetxController {
  final db = FirebaseFirestore.instance;
  var parkir = Parkir();
  TextEditingController merek = TextEditingController();
  TextEditingController nomorPlat = TextEditingController();
  String? dropdownValue;
  List<String> dropdownItems = ['Sepeda Motor', 'Mobil'];
  String? idPetugas;

  void parkirMasuk() {
    if (dropdownValue != null && merek.text != '' && nomorPlat.text != '') {
      db.collection('parking').add({
        'nomor_plat': nomorPlat.text,
        // 'nomor_plat': parkir.nomorPlat,
        'jenis_kendaraan': dropdownValue,
        // 'jenis_kendaraan': parkir.jenisKendaraan,
        'merek_kendaraan': merek.text,
        // 'merek_kendaraan': parkir.merekKendaraan,
        'nama_pengendara': 'Tamu',
        // 'nama_pengendara': parkir.namaPengendara,
        'masuk': FieldValue.serverTimestamp(),
        'petugas_masuk': idPetugas,
        // 'petugas_masuk': parkir.petugasMasuk,
        'active': true
      });
      Get.back();
      Get.defaultDialog(middleText: 'Kendaraan Masuk');
    } else {
      Get.defaultDialog(middleText: 'Semua data harus diisi');
    }
  }

  void cariKendaraan() {
    db
        .collection('parking')
        .where('nomor_plat', isEqualTo: nomorPlat.text.toUpperCase())
        .where('active', isEqualTo: true)
        .where('nama_pengendara', isEqualTo: 'Tamu')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        var data = value.docs[0].reference.id;
        Get.toNamed(Routes.KENDARAAN_TAMU_KELUAR_DETAIL, arguments: data);
      } else {
        Get.defaultDialog(middleText: 'Kendaraan tidak ada');
      }
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataParkir(
      String idParkir) {
    var parkir = db.collection('parking').doc(idParkir).get();
    return parkir;
  }

  void parkirKeluar(String idParkir) {
    db.collection('parking').doc(idParkir).update({
      'keluar': FieldValue.serverTimestamp(),
      'petugas_keluar': idPetugas,
      'active': false
    });
    Get.back();
    Get.defaultDialog(middleText: 'Kendaraan Keluar');
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataPetugas(
      String idPetugas) {
    var dataPetugas = db.collection('users').doc(idPetugas);
    return dataPetugas.get();
  }
}
