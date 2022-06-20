import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/controllers/auth_controller.dart';
import 'package:unbaja_parking_app/pages/home_page.dart';
import 'package:unbaja_parking_app/routes/page_navigation_route.dart';
import 'package:unbaja_parking_app/routes/page_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unbaja_parking_app/utils/loading.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authController = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authController.authStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            initialRoute:
                snapshot.data != null ? PageName.home : PageName.login,
            getPages: PageNavigationRoute.pages,
          );
        }
        return const LoadingView();
      },
    );
  }
}
