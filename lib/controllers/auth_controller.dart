import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/routes/page_name.dart';

class AuthController extends GetxController {
  // Cek status Auth (Apakah user Masuk atau Keluar)
  Stream<User?> authStatus() {
    return FirebaseAuth.instance.authStateChanges();
  }

  // Alert Dialog
  void alertDialog(String message) {
    Get.defaultDialog(title: 'Perhatian!', middleText: message);
  }

  // Fungsi Login
  void login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.offNamed(PageName.home);
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

  // Fungsi Logout
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(PageName.login);
  }

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
