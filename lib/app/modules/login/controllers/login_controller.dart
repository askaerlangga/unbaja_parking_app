import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var obsecure = true.obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // Alert Dialog
  void alertDialog(String message) {
    Get.defaultDialog(
        title: 'Perhatian',
        middleText: message,
        onCancel: () => Get.back(),
        textCancel: 'Ok');
  }

  // Fungsi Login
  void login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user!.emailVerified) {
        Get.offNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
            title: 'Perhatian',
            middleText:
                'Akun kamu belum diverifikasi, silahkan cek email kamu untuk verifikasi',
            onCancel: () => Get.back(),
            onConfirm: () async {
              Get.back();
              alertDialog('Berhasil kirim ulang Email verifikasi');
              await credential.user!.sendEmailVerification();
            },
            textCancel: 'Ok',
            textConfirm: 'Kirim ulang',
            confirmTextColor: Colors.white);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        alertDialog('Email tersebut tidak terdaftar');
      } else if (e.code == 'wrong-password') {
        alertDialog('Password yang anda masukan salah');
      }
    }
  }
}
