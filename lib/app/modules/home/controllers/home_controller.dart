import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  // Fungsi Logout
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
