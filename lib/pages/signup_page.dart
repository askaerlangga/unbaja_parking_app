import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/bindings/signup_page_binding.dart';
import 'package:unbaja_parking_app/controllers/signup_page_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final signUpPageController = Get.find<SignUpPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Akun')),
      body: ListView(padding: EdgeInsets.all(20), children: <Widget>[
        // Textfield Email
        TextField(
          // controller: textfieldController.email,
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
            // controller: textfieldController.password,
            obscureText: signUpPageController.obsecure.value,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
                suffixIcon: IconButton(
                    onPressed: () {
                      signUpPageController.obsecure.toggle();
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
                onPressed: () {},
                child: Text('DAFTAR'))),
      ]),
    );
  }
}
