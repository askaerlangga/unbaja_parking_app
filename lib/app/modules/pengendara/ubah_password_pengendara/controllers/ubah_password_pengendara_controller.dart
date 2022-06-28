import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UbahPasswordPengendaraController extends GetxController {
  TextEditingController passwordLama = TextEditingController();
  TextEditingController passwordBaru = TextEditingController();
  TextEditingController passwordBaruConfirm = TextEditingController();

  Future<void> ubahPassword(String newPassword, String passwordLama) async {
    var db = FirebaseAuth.instance;
    // db.currentUser.reauthenticateWithCredential(credential)

    var user = db.currentUser;
    if (this.passwordLama.text != '' &&
        passwordBaru.text != '' &&
        passwordBaruConfirm.text != '') {
      if (passwordBaru.text == passwordBaruConfirm.text) {
        if (user != null) {
          Get.defaultDialog(
              title: 'Ganti Password',
              middleText: 'Apakah anda yakin ingin mengubah password?',
              textCancel: 'Batal',
              textConfirm: 'Ubah',
              onConfirm: () async {
                try {
                  final credential = EmailAuthProvider.credential(
                      email: user.email!, password: passwordLama);
                  await user.reauthenticateWithCredential(credential);
                  await user.updatePassword(newPassword);
                  Get.back();
                  Get.defaultDialog(
                      title: 'Ganti Password',
                      middleText: 'Berhasil mengubah password',
                      textCancel: 'Ok',
                      onCancel: () {
                        Get.back();
                      });
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'wrong-password') {
                    Get.back();
                    Get.defaultDialog(
                        middleText: 'Password Lama anda salah!',
                        textCancel: 'Ok');
                  }
                }
              });
        }
      } else {
        Get.defaultDialog(
            middleText: 'Password baru dan Konfirmasi password baru tidak sama',
            textCancel: 'Ok');
      }
    } else {
      Get.defaultDialog(
          middleText: 'Password tidak boleh kosong!', textCancel: 'Ok');
    }
  }
}
