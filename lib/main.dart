import 'package:flutter/material.dart';
import 'package:luminar_api_sample_april_2025/controller/add_screen_controller.dart';
import 'package:luminar_api_sample_april_2025/controller/home_contrller.dart';
import 'package:luminar_api_sample_april_2025/controller/login_controller.dart';
import 'package:luminar_api_sample_april_2025/view/login_screen/login_screen.dart';
import 'package:luminar_api_sample_april_2025/view/spalsh_screen/splash_screen.dart';
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
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => AddScreenController()),
      ],
      child: MaterialApp(home: SplashScreen()),
    );
  }
}
