import 'package:flutter/material.dart';
import 'package:flutter_meet_ta/components/my_textfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "M e e t  T a",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                MyTextfield(
                  labelText: "Username",
                  controller: _usernameController,
                  isAutoFocus: true,
                ),
                const SizedBox(height: 16.0),
                MyTextfield(
                  labelText: "Password",
                  controller: _passwordController,
                  isObscure: true,
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
