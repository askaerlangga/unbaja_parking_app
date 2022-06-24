import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/controllers/auth_controller.dart';
import 'package:unbaja_parking_app/app/modules/home/controllers/home_controller.dart';
import 'package:unbaja_parking_app/app/modules/home/views/admin_view.dart';
import 'package:unbaja_parking_app/app/modules/home/views/pengendara_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var userUID = auth.uid.value;
      if (userUID != '') {
        return FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.userLevelCheck(
                (Get.arguments == null) ? userUID : Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data =
                    (snapshot.data!.data() as Map<String, dynamic>)['level'];
                print('PRINT SNAPSHOT ${data}');
                if (data == 'admin') {
                  return const AdminView();
                } else if (data == 'pengendara') {
                  return const PengendaraView();
                }
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            });
      }

      return const Scaffold(
        body: Center(
          child: Text('UserUID tidak Tersedia'),
        ),
      );
    });
  }
}
