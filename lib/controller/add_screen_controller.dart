import 'package:flutter/material.dart';
import 'package:luminar_api_sample_april_2025/services/api_services/api_service.dart';
import 'package:luminar_api_sample_april_2025/utils/app_utils.dart';

class AddScreenController with ChangeNotifier {
  bool isLoading = false;
  Future<bool> addProduct({
    required String name,
    required String desc,
    required String price,
    required String stock,
    required String category,
  }) async {
    isLoading = true;
    notifyListeners();
    String token = await AppUtils.getToken();
    final response = await ApiServices.postData(
      enpointUrl: '/product-create/',
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      postBody: {
        "name": name,
        "description": desc,
        "price": double.parse(price),
        "stock": int.parse(stock),
        "category": category,
      },
    );

    if (response != null) {
      print("product added Successfull");
      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();

    return false;
  }
}
