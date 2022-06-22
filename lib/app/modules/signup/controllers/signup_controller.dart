import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var obsecure = true.obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // Fungsi SignUp
  void signup(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        Get.defaultDialog(middleText: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        Get.defaultDialog(
            middleText: 'The account already exists for that email.');
      }
    } catch (e) {
      Get.defaultDialog(middleText: e.toString());
    }
  }
}
