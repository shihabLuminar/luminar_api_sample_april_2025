import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:luminar_api_sample_april_2025/model/login_res_model.dart';
import 'package:luminar_api_sample_april_2025/services/api_services/api_service.dart';
import 'package:luminar_api_sample_april_2025/utils/app_utils.dart';
import 'package:luminar_api_sample_april_2025/view/home_screen/home_screen.dart';

class LoginController with ChangeNotifier {
  bool isLoading = false;

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    final response = await ApiServices.postData(
      enpointUrl: "/login",
      postBody: {"email": email, "password": password},
    );
    if (response != null) {
      LoginResModel loginData = loginResModelFromJson(response);

      log(loginData.access.toString());

      // store token to local db
      await AppUtils.storeToken(loginData.access.toString());

      // navigate to home page on successful login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    }
    isLoading = false;
    notifyListeners();
  }
}
