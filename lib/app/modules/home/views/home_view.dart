import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/controllers/auth_controller.dart';
import 'package:unbaja_parking_app/app/modules/home/controllers/home_controller.dart';
import 'package:unbaja_parking_app/app/modules/home/views/admin/admin_view.dart';
import 'package:unbaja_parking_app/app/modules/home/views/pengendara/pengendara_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unbaja_parking_app/app/modules/home/views/petugas/petugas_view.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.uid = auth.uid.value;
      if (controller.uid != '') {
        return FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.userLevelCheck(
                (Get.arguments == null) ? auth.uid.value : Get.arguments),
            builder: (context, snapshot) {
              // Cek user level
              if (snapshot.connectionState == ConnectionState.done) {
                var data = (snapshot.data!.data() as Map<String, dynamic>);
                print('PRINT SNAPSHOT ${data}');
                controller.nameUser.value = data['nama'] ?? '';
                controller.levelUser.value = data['level'] ?? '';
                if (data['level'] == 'admin') {
                  return const AdminView();
                } else if (data['level'] == 'pengendara') {
                  return const PengendaraView();
                } else if (data['level'] == 'petugas') {
                  return const PetugasView();
                }
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            });
      }

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
