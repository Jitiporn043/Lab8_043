import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:lab8_043/services/auth_services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าแรก'),
        backgroundColor: const Color.fromARGB(255, 233, 120, 157),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: GoogleAuthButton(
            onPressed: () {
              authServices.signInWithGoogle().then(
                (value) {
                  print(value);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
