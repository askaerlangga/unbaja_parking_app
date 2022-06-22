import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/controllers/auth_controller.dart';
import 'package:unbaja_parking_app/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final authController = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authController.authStatus(),
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            title: 'UNBAJA Parking',
            initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
