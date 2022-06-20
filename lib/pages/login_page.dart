import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/controllers/login_page_controller.dart';
import 'package:unbaja_parking_app/routes/page_name.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final loginPageController = Get.find<LoginPageController>();
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
                  controller: loginPageController.email,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Textfield Password
                TextField(
                  controller: loginPageController.password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      border: OutlineInputBorder()),
                ),

                // Tombol lupa password
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
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
                          Get.offNamed(PageName.home);
                        },
                        child: Text('LOGIN'))),

                // Tombol Daftar akun
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Belum punya akun?'),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(PageName.signup);
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
