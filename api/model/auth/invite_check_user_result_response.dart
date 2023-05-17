// To parse this JSON data, do
//
//     final inviteCheckUserResultResponse = inviteCheckUserResultResponseFromJson(jsonString);

import 'dart:convert';

InviteCheckUserResultResponse inviteCheckUserResultResponseFromJson(String str) => InviteCheckUserResultResponse.fromJson(json.decode(str));

String inviteCheckUserResultResponseToJson(InviteCheckUserResultResponse data) => json.encode(data.toJson());

class InviteCheckUserResultResponse {
  InviteCheckUserResultResponse({
    this.result,
    this.userData,
    this.message,
  });

  bool? result;
  int? userData;
  String? message;

  factory InviteCheckUserResultResponse.fromJson(Map<String, dynamic> json) => InviteCheckUserResultResponse(
        result: json["result"] == null ? null : json["result"],
        userData: json["userData"] == null ? null : json["userData"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "userData": userData == null ? null : userData,
        "message": message == null ? null : message,
      };
}
