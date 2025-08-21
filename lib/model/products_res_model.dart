// To parse this JSON data, do
//
//     final productsResModel = productsResModelFromJson(jsonString);

import 'dart:convert';

ProductsResModel productsResModelFromJson(String str) =>
    ProductsResModel.fromJson(json.decode(str));

String productsResModelToJson(ProductsResModel data) =>
    json.encode(data.toJson());

class ProductsResModel {
  String? msg;
  List<ProductModel>? producs;

  ProductsResModel({this.msg, this.producs});

  factory ProductsResModel.fromJson(Map<String, dynamic> json) =>
      ProductsResModel(
        msg: json["Msg"],
        producs: json["data"] == null
            ? []
            : List<ProductModel>.from(
                json["data"]!.map((x) => ProductModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "Msg": msg,
    "data": producs == null
        ? []
        : List<dynamic>.from(producs!.map((x) => x.toJson())),
  };
}

class ProductModel {
  num? id;
  String? name;
  String? description;
  num? price;
  num? stock;
  String? category;
  dynamic imageUrl;
  num? user;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.category,
    this.imageUrl,
    this.user,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    stock: json["stock"],
    category: json["category"],
    imageUrl: json["image_url"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "stock": stock,
    "category": category,
    "image_url": imageUrl,
    "user": user,
  };
}
