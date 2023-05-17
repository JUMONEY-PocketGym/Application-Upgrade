// To parse this JSON data, do
//
//     final videoUploadPreModel = videoUploadPreModelFromJson(jsonString);

import 'dart:convert';

VideoUploadPreModel videoUploadPreModelFromJson(String str) => VideoUploadPreModel.fromJson(json.decode(str));

String videoUploadPreModelToJson(VideoUploadPreModel data) => json.encode(data.toJson());

class VideoUploadPreModel {
  VideoUploadPreModel({
    this.statusCode,
    this.message,
    this.questRecordUid,
  });

  int? statusCode;
  String? message;
  int? questRecordUid;

  factory VideoUploadPreModel.fromJson(Map<String, dynamic> json) => VideoUploadPreModel(
        statusCode: json["statusCode"],
        message: json["message"],
        questRecordUid: json["questRecordUid"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "questRecordUid": questRecordUid,
      };
}
