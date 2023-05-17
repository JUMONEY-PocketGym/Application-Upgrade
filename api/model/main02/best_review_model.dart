// To parse this JSON data, do
//
//     final bestReviewItemResponse = bestReviewItemResponseFromJson(jsonString);

import 'dart:convert';

BestReviewItemResponse? bestReviewItemResponseFromJson(String str) => BestReviewItemResponse.fromJson(json.decode(str));

String bestReviewItemResponseToJson(BestReviewItemResponse? data) => json.encode(data!.toJson());

class BestReviewItemResponse {
  BestReviewItemResponse({
    // this.idx,
    this.userProfileImg,
    this.name,
    this.date,
    this.title,
    this.content,
    this.images,
  });

  // int? idx;
  String? userProfileImg;
  String? name;
  String? date;
  String? title;
  String? content;
  List<String?>? images;

  factory BestReviewItemResponse.fromJson(Map<String, dynamic> json) => BestReviewItemResponse(
        // idx: json["idx"],
        userProfileImg: json["userProfileImg"],
        name: json["name"],
        date: json["date"],
        title: json["title"],
        content: json["content"],
        images: json["images"] == null
            ? []
            : json["images"] == null
                ? []
                : List<String?>.from(json["images"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        // "idx": idx,
        "userProfileImg": userProfileImg,
        "name": name,
        "date": date,
        "title": title,
        "content": content,
        "images": images == null
            ? []
            : images == null
                ? []
                : List<dynamic>.from(images!.map((x) => x)),
      };
}
