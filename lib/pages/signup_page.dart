import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
        TextField(
          // controller: textfieldController.password,
          obscureText: true,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: 'Password',
              border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 20,
        ),
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
