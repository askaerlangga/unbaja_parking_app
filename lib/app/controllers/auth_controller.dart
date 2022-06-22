import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Cek status Auth (Apakah user Masuk atau Keluar)
  Stream<User?> authStatus() {
    return FirebaseAuth.instance.authStateChanges();
  }
}
