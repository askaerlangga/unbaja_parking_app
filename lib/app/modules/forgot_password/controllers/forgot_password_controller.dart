import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController email = TextEditingController();

  // Alert Dialog
  void alertDialog(String message) {
    Get.defaultDialog(
        title: 'Perhatian', middleText: message, textCancel: 'Ok');
  }

  void forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
          title: 'Perhatian',
          middleText:
              'Link untuk reset password berhasil dikirim ke email kamu',
          onCancel: () {
            Get.back();
            Get.back();
          },
          textCancel: 'Ok');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        alertDialog('Email yang kamu masukan salah');
      } else if (e.code == 'user-not-found') {
        alertDialog('Email yang kamu masukkan tidak terdaftar');
      }
    }
  }
}
