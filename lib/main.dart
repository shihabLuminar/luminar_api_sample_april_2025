import 'package:flutter/material.dart';
import 'package:luminar_api_sample_april_2025/controller/login_controller.dart';
import 'package:luminar_api_sample_april_2025/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
      ],
      child: MaterialApp(home: LoginScreen()),
    );
  }
}
