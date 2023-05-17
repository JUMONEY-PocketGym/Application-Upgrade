// To parse this JSON data, do
//
//     final categoryListResponse = categoryListResponseFromJson(jsonString);

import 'dart:convert';

CategoryListResponse categoryListResponseFromJson(String str) => CategoryListResponse.fromJson(json.decode(str));

String categoryListResponseToJson(CategoryListResponse data) => json.encode(data.toJson());

class CategoryListResponse {
  CategoryListResponse({
    this.soloCategory,
    this.togetherCategory,
  });

  List<Category>? soloCategory;
  List<Category>? togetherCategory;

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) => CategoryListResponse(
        soloCategory: json["soloCategory"] == null ? null : List<Category>.from(json["soloCategory"].map((x) => Category.fromJson(x))),
        togetherCategory: json["togetherCategory"] == null ? null : List<Category>.from(json["togetherCategory"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "soloCategory": soloCategory == null ? null : List<dynamic>.from(soloCategory!.map((x) => x.toJson())),
        "togetherCategory": togetherCategory == null ? null : List<dynamic>.from(togetherCategory!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.categoryUuid,
    this.categoryName,
  });

  String? categoryUuid;
  String? categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryUuid: json["categoryUuid"] == null ? null : json["categoryUuid"],
        categoryName: json["categoryName"] == null ? null : json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "categoryUuid": categoryUuid == null ? null : categoryUuid,
        "categoryName": categoryName == null ? null : categoryName,
      };
}
