import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:luminar_api_sample_april_2025/model/login_res_model.dart';
import 'package:luminar_api_sample_april_2025/services/api_services/api_service.dart';

class LoginController with ChangeNotifier {
  bool isLoading = false;

  Future<void> login({required String email, required String password}) async {
    isLoading = true;
    notifyListeners();

    final response = await ApiServices.postData(
      enpointUrl: "/login",
      postBody: {"email": email, "password": password},
    );
    if (response != null) {
      LoginResModel loginData = loginResModelFromJson(response);
      log(loginData.email.toString());
      log(loginData.access.toString());
    }
    isLoading = false;
    notifyListeners();
  }
}
