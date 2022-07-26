import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/models/pengguna.dart';

class UbahDataPenggunaController extends GetxController {
  final db = FirebaseFirestore.instance;
  var pengguna = Pengguna();

  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController nomorTelepon = TextEditingController();
  TextEditingController nomorIdentitas = TextEditingController();

  String? dropdownValue;
  List<String> dropdownItems = ['Mahasiswa', 'Dosen', 'Pegawai'];

  void ubahDataPengguna(String referenceId, String nama, String alamat,
      String nomorTelepon, String nomorIdentitas, String status) {
    try {
      if (this.nama.text != '' &&
          this.alamat.text != '' &&
          this.nomorTelepon.text != '' &&
          this.nomorIdentitas.text != '' &&
          dropdownValue != null) {
        Get.defaultDialog(
            title: 'Ubah Data',
            middleText: 'Apakah anda yakin ingin mengubah data?',
            textCancel: 'Batal',
            textConfirm: 'Ubah',
            confirmTextColor: Colors.white,
            onConfirm: () {
              try {
                var docRef = db.collection('users').doc(referenceId);
                docRef.update({
                  'nama': nama,
                  'alamat': alamat,
                  'nomor_telepon': nomorTelepon,
                  'nomor_identitas': nomorIdentitas,
                  'status': status
                });
                Get.back();
                Get.defaultDialog(
                    title: 'Ubah Data',
                    middleText: 'Berhasil mengubah data pengguna',
                    textCancel: 'Ok',
                    onCancel: () {
                      Get.back();
                    });
              } catch (e) {
                print(e);
                Get.defaultDialog(middleText: 'Ubah data gagal');
              }
            },
            onCancel: () {
              Get.back();
            });
      } else {
        print(this.nama.text);
        print(this.alamat.text);
        print(this.nomorTelepon.text);
        print(this.nomorIdentitas.text);
        print(dropdownValue);
        Get.defaultDialog(middleText: 'Data tidak boleh ada yang kosong!');
      }
    } catch (e) {}
  }
}
