import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var obsecure = true.obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // Alert Dialog
  void alertDialog(String message) {
    Get.defaultDialog(
        title: 'Perhatian', middleText: message, onConfirm: () => Get.back());
  }

  // Fungsi SignUp
  void signup(String email, String password) async {
    var db = FirebaseFirestore.instance;
    try {
      if (this.email.text != '' && this.password.text != '') {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Verifikasi Email
        await credential.user!.sendEmailVerification();

        // User level ke firestore
        db
            .collection('users')
            .doc(credential.user!.uid)
            .set({'level': 'pengendara'}).onError(
                (error, stackTrace) => print('Gagal menulis data ${error}'));

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
