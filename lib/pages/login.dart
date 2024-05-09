import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_meet_ta/components/my_button.dart';
import 'package:flutter_meet_ta/components/my_textfield.dart';
import 'package:flutter_meet_ta/components/show_alert.dart';
import 'package:flutter_meet_ta/session_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          Form(
            key: _formKey,
            child: Padding(
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
                  ),
                  const SizedBox(height: 16.0),
                  MyButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        handleLogin();
                      }
                    },
                    text: "Login",
                    color: Theme.of(context).colorScheme.primaryContainer,
                    size: 16,
                  )
                ]),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed("/signup");
            },
            child: const Text("Don't have an account? Sign up"),
          )
        ],
      ),
    );
  }

  void handleLogin() async {
    try {
      var url = Uri.parse("${SessionStorage.url}user.php");
      Map<String, String> jsonData = {
        "username": _usernameController.text,
        "password": _passwordController.text,
      };

      Map<String, dynamic> requestBody = {
        "operation": "login",
        "json": jsonEncode(jsonData),
      };

      var response = await http.post(url, body: requestBody);
      var res = jsonDecode(response.body);
      if (res != 0) {
        ShowAlert().showAlert("success", "Welcome ${res['user_firstName']}!");
      } else {
        ShowAlert().showAlert("danger", "Invalid username or password!");
      }
    } catch (e) {
      ShowAlert().showAlert("danger", "Network problem!");
      print("network problem sa login.dart handleLogin function: $e");
    }
  }
}
