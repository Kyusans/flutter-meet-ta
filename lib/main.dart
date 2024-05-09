import 'package:flutter/material.dart';
import 'package:flutter_meet_ta/pages/login.dart';
import 'package:flutter_meet_ta/pages/signup.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      routes: {
        "/login": (context) => const Login(),
        "/signup": (context) => const Signup(),
      },
      home: const Scaffold(
        body: Login(),
      ),
    );
  }
}
