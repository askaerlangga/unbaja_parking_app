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
    try {
      if (this.email.text != '' && this.password.text != '') {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Verifikasi Email
        await credential.user!.sendEmailVerification();

        Get.defaultDialog(
            title: 'Daftar akun berhasil',
            middleText: 'Sekarang kamu sudah bisa login',
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