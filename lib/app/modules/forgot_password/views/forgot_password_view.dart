import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lupa Password')),
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
          height: 20,
        ),

        // Tombol Kirim
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                onPressed: () {
                  controller.forgotPassword(controller.email.text);
                },
                child: Text('KIRIM'))),
      ]),
    );
  }
}
