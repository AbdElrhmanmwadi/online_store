// To parse this JSON data, do
//
// final catrgoridModel = catrgoridModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CatrgoridModel catrgoridModelFromJson(String str) =>
    CatrgoridModel.fromJson(json.decode(str));

class CatrgoridModel {
  CatrgoridModel({
    required this.categories,
  });

  List<Category> categories;

  factory CatrgoridModel.fromJson(Map<String, dynamic> json) => CatrgoridModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );
}

class Category {
  Category({
    required this.name,
    required this.subcategory,
  });

  String name;
  List<String> subcategory;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
      );
}
