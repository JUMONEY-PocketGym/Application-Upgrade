// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.refreshToken,
    this.accessToken,
    this.uid,
  });

  String? refreshToken;
  String? accessToken;
  int? uid;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        refreshToken: json["refreshToken"] == null ? null : json["refreshToken"],
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
        uid: json["uid"] == null ? null : json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken == null ? null : refreshToken,
        "accessToken": accessToken == null ? null : accessToken,
        "uid": uid == null ? null : uid,
      };
}
