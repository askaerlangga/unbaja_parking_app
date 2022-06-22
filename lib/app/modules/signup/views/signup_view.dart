import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Akun')),
      body: ListView(padding: EdgeInsets.all(20), children: <Widget>[
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
        SizedBox(
          height: 20,
        ),

        // Tombol Daftar
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                onPressed: () {
                  controller.signup(
                      controller.email.text, controller.password.text);
                },
                child: Text('DAFTAR'))),
      ]),
    );
  }
}
