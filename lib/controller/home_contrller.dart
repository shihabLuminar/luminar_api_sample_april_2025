import 'package:flutter/material.dart';
import 'package:luminar_api_sample_april_2025/model/products_res_model.dart';
import 'package:luminar_api_sample_april_2025/services/api_services/api_service.dart';
import 'package:luminar_api_sample_april_2025/utils/app_utils.dart';

class HomeController with ChangeNotifier {
  bool isLoading = false;
  List<ProductModel> products = [];

  Future<void> fetchMyProducts() async {
    isLoading = true;
    notifyListeners();

    String token = await AppUtils.getToken();

    final response = await ApiServices.getData(
      enpointUrl: "/my-products/",
      headers: {"Authorization": "Bearer $token"},
    );

    if (response != null) {
      ProductsResModel resData = productsResModelFromJson(response);
      products = resData.producs ?? [];
    }

    isLoading = false;
    notifyListeners();
  }
}
