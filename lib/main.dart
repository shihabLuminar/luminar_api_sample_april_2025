import 'package:flutter/material.dart';
import 'package:luminar_api_sample_april_2025/view/login_screen/login_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen());
  }
}
