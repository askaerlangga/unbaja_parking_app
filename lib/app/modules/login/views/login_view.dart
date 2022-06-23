import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UNBAJA Parking'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          // Logo Aplikasi Parkir
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Container(
                color: Colors.white,
                height: 80,
                width: 80,
                child: const Icon(
                  Icons.local_parking,
                  size: 60,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                // Textfield Email
                TextField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Textfield Password
                Obx(
                  () => TextField(
                    controller: controller.password,
                    obscureText: controller.obsecure.value,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.obsecure.toggle();
                            },
                            icon: Icon(Icons.remove_red_eye)),
                        border: OutlineInputBorder()),
                  ),
                ),

                // Tombol lupa password
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.FORGOT_PASSWORD);
                        },
                        child: const Text(
                          'Lupa password?',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ))),

                // Tombol Login
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                        onPressed: () {
                          controller.login(
                              controller.email.text, controller.password.text);
                        },
                        child: Text('LOGIN'))),

                // Tombol Daftar akun
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Belum punya akun?'),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.SIGNUP);
                        },
                        child: const Text('Daftar')),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
