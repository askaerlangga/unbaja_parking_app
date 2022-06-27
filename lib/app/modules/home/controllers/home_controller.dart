import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/controllers/auth_controller.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  var uid = '';
  var nameUser = ''.obs;
  var levelUser = ''.obs;

  // Fungsi cek user level
  Future<DocumentSnapshot<Object?>> userLevelCheck(String uid) {
    var db = FirebaseFirestore.instance;
    DocumentReference user = db.collection("users").doc(uid);
    return user.get();
  }

  // Fungsi Logout
  void logout() {
    Get.defaultDialog(
        title: 'Logout',
        middleText: 'Apakah anda yakin ingin logout?',
        textCancel: 'Tidak',
        textConfirm: 'Ya',
        onCancel: () => Get.back(),
        onConfirm: () async {
          await FirebaseAuth.instance.signOut();
          var auth = Get.find<AuthController>();
          auth.uid = '';
          Get.offAllNamed(Routes.LOGIN);
        });
  }
}
