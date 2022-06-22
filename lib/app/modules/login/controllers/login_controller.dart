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
    Get.defaultDialog(title: 'Perhatian!', middleText: message);
  }

  // Fungsi Login
  void login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.offNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        alertDialog('Email tersebut tidak terdaftar');
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        alertDialog('Password yang anda masukan salah');
      }
    }
  }
}
