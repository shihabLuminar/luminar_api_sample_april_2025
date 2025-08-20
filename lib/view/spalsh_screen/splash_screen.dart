import 'dart:async';

import 'package:flutter/material.dart';
import 'package:luminar_api_sample_april_2025/utils/app_utils.dart';
import 'package:luminar_api_sample_april_2025/view/home_screen/home_screen.dart';
import 'package:luminar_api_sample_april_2025/view/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 3 seconds then navigate
    Timer(const Duration(seconds: 3), () async {
      String storedToken = await AppUtils.getToken();

      if (storedToken.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FlutterLogo(
          // Flutter Dash logo
          size: 150,
        ),
      ),
    );
  }
}
