import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahAkunController extends GetxController {
  final db = FirebaseFirestore.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController nomorTelepon = TextEditingController();
  TextEditingController nomorIdentitas = TextEditingController();

  String? dropdownValue;
  List<String> dropdownItems = ['Dosen', 'Pegawai'];

  // Alert Dialog
  void alertDialog(String message) {
    Get.defaultDialog(
        title: 'Perhatian', middleText: message, onConfirm: () => Get.back());
  }

  // Fungsi SignUp
  void tambahAkun(
      String email,
      String password,
      String nama,
      String alamat,
      String nomorTelepon,
      String nomorIdentitas,
      String status,
      String level) async {
    var db = FirebaseFirestore.instance;
    try {
      if (this.email.text != '' &&
          this.password.text != '' &&
          this.nama.text != '' &&
          this.alamat.text != '' &&
          this.nomorTelepon.text != '' &&
          this.nomorIdentitas.text != '' &&
          dropdownValue != null) {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Verifikasi Email
        await credential.user!.sendEmailVerification();

        // User level ke firestore
        db.collection('users').doc(credential.user!.uid).set({
          'nama': nama,
          'alamat': alamat,
          'nomor_telepon': nomorTelepon,
          'nomor_identitas': nomorIdentitas,
          'status': status,
          'level': level
        }).onError((error, stackTrace) => print('Gagal menulis data ${error}'));

        Get.defaultDialog(
            title: 'Daftar akun berhasil',
            middleText:
                'Link verifikasi sudah dikirim ke Email kamu, silahkan verifikasi untuk menggunakan Akun',
            onConfirm: () {
              Get.back();
              Get.back();
            });
      } else {
        alertDialog('Email dan password tidak boleh kosong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        alertDialog(
            'Password yang kamu masukkan terlalu lemah, dan pastikan terdiri dari 6 karakter');
      } else if (e.code == 'email-already-in-use') {
        alertDialog(
            'Email yang kamu masukkan sudah terdaftar.\nsilahkan gunakan email lain');
      } else if (e.code == 'invalid-email') {
        alertDialog('Penulisan email salah.\ncontoh : emailku@gmail.com');
      }
    } catch (e) {
      Get.defaultDialog(middleText: e.toString());
    }
  }
}
