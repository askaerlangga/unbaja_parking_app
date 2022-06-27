import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // UserUID untuk initialRoute
  var uid = '';

  // Cek status Auth (Apakah user Masuk atau Keluar)
  Stream<User?> authStatus() {
    return FirebaseAuth.instance.authStateChanges();
  }
}
