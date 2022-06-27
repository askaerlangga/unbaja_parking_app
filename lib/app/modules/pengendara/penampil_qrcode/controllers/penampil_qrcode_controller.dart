import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PenampilQrcodeController extends GetxController {
  Future<DocumentSnapshot<Object?>> getUserData(String uid) {
    var db = FirebaseFirestore.instance;
    DocumentReference user = db.collection("users").doc(uid);
    return user.get();
  }
}
