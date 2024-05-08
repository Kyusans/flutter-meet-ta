import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_meet_ta/components/my_button.dart';
import 'package:flutter_meet_ta/components/my_textfield.dart';
import 'package:flutter_meet_ta/components/show_alert.dart';
import 'package:flutter_meet_ta/session_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Sign up",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: MyTextfield(
                      labelText: "First Name",
                      controller: firstNameController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MyTextfield(
                      labelText: "Last Name",
                      controller: lastNameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MyTextfield(
                labelText: "Username",
                controller: userNameController,
              ),
              const SizedBox(height: 16),
              MyTextfield(
                labelText: "Password",
                controller: passwordController,
                isObscure: true,
              ),
              const SizedBox(height: 16),
              MyTextfield(
                labelText: "Email",
                controller: emailController,
                isEmail: true,
              ),
              const SizedBox(height: 16),
              MyButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    handleSignUp();
                  }
                },
                text: "Sign up",
                color: Theme.of(context).colorScheme.primaryContainer,
                size: 16,
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleSignUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var url = Uri.parse("${SessionStorage.url}user.php");
      Map<String, String> jsonData = {
        "username": userNameController.text,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "password": passwordController.text,
        "email": emailController.text
      };

      Map<String, dynamic> requestBody = {
        "operation": "signup",
        "json": jsonEncode(jsonData),
      };
      var response = await http.post(url, body: requestBody);
      var res = jsonDecode(response.body);
      print("res ni handleSignUp: $res");
      if (res == -1) {
        ShowAlert().showAlert("danger", "Username already exists");
      } else if (res == -2) {
        ShowAlert().showAlert("danger", "Email already exists");
      } else if (res == 1) {
        ShowAlert().showAlert("success", "Account created successfully");
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        ShowAlert()
            .showAlert("danger", "There's something wrong, please try again");
        print("network problem sa signup.dart handleSignUp function: $res");
      }
    } catch (e) {
      ShowAlert().showAlert("danger", "Network problem");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
