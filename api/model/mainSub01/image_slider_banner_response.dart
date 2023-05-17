// To parse this JSON data, do
//
//     final imageSliderBannerResponse = imageSliderBannerResponseFromJson(jsonString);

import 'dart:convert';

List<ImageSliderBannerResponse> imageSliderBannerResponseFromJson(String str) => List<ImageSliderBannerResponse>.from(json.decode(str).map((x) => ImageSliderBannerResponse.fromJson(x)));

String imageSliderBannerResponseToJson(List<ImageSliderBannerResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageSliderBannerResponse {
  ImageSliderBannerResponse({
    this.imageUrl,
    this.target,
  });

  String? imageUrl;
  Target? target;

  factory ImageSliderBannerResponse.fromJson(Map<String, dynamic> json) => ImageSliderBannerResponse(
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        target: json["target"] == null ? null : Target.fromJson(json["target"]),
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl == null ? null : imageUrl,
        "target": target == null ? null : target!.toJson(),
      };
}

class Target {
  Target({
    this.targetPath,
    this.targetOption,
  });

  String? targetPath;
  String? targetOption;

  factory Target.fromJson(Map<String, dynamic> json) => Target(
        targetPath: json["targetPath"] == null ? null : json["targetPath"],
        targetOption: json["targetOption"] == null ? null : json["targetOption"],
      );

  Map<String, dynamic> toJson() => {
        "targetPath": targetPath == null ? null : targetPath,
        "targetOption": targetOption == null ? null : targetOption,
      };
}
