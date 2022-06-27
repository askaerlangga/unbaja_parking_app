import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/controllers/auth_controller.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  var db = FirebaseFirestore.instance;
  var uid = '';
  var nameUser = ''.obs;
  var levelUser = ''.obs;

  // Fungsi cek user level
  Future<DocumentSnapshot<Object?>> userLevelCheck(String uid) {
    DocumentReference user = db.collection("users").doc(uid);
    return user.get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) {
    var userData = db.collection('users').doc(uid);
    return userData.snapshots();
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
          auth.uid.value = '';
          Get.offAllNamed(Routes.LOGIN);
        });
  }
}
