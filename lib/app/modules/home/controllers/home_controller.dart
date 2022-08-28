import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getKendaraanTerparkir() {
    var timeNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var firstTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 00:00:00').millisecondsSinceEpoch);
    var lastTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 23:59:00').millisecondsSinceEpoch);
    var listKendaraan = db
        .collection('parking')
        .where('active', isEqualTo: true)
        .where('masuk', isLessThan: lastTime)
        .where('masuk', isGreaterThan: firstTime)
        .snapshots();
    return listKendaraan;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getKendaraanMasuk() {
    var timeNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var firstTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 00:00:00').millisecondsSinceEpoch);
    var lastTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 23:59:00').millisecondsSinceEpoch);
    var listKendaraan = db
        .collection('parking')
        .where('masuk', isLessThan: lastTime)
        .where('masuk', isGreaterThan: firstTime)
        .snapshots();
    return listKendaraan;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getKendaraanKeluar() {
    var timeNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var firstTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 00:00:00').millisecondsSinceEpoch);
    var lastTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 23:59:00').millisecondsSinceEpoch);
    var listKendaraan = db
        .collection('parking')
        .where('keluar', isLessThan: lastTime)
        .where('keluar', isGreaterThan: firstTime)
        .snapshots();
    return listKendaraan;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getJumlahPengguna() {
    var listPengguna = db.collection('users').snapshots();
    return listPengguna;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getJumlahKendaraan() {
    var listKendaraan = db.collection('vehicles').snapshots();
    return listKendaraan;
  }

  // Penugasan
  String? penugasanValue;
  List<String> penugasanItems = ['Kampus 1', 'Kampus 2'];

  // Ubah tempat bertugas
  void ubahPenugasan(String uid, String lokasi) {
    Get.defaultDialog(
        middleText: 'Ubah tempat bertugas?',
        textConfirm: 'Ubah',
        textCancel: 'Batal',
        onConfirm: () {
          db.collection('users').doc(uid).update({'penugasan': lokasi});
          Get.back();
          Get.defaultDialog(middleText: 'Tempat bertugas berhasil diubah!');
        });
  }
}
