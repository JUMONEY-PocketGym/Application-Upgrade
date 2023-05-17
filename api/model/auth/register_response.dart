// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.result,
    this.resultMsg,
    this.resultCode,
    this.refreshToken,
    this.accessToken,
    this.uid,
  });

  String? result;
  String? resultMsg;
  int? resultCode;
  String? refreshToken;
  String? accessToken;
  int? uid;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
        result: json["result"] == null ? null : json["result"],
        resultMsg: json["resultMsg"] == null ? null : json["resultMsg"],
        resultCode: json["resultCode"] == null ? null : json["resultCode"],
        refreshToken: json["refreshToken"] == null ? null : json["refreshToken"],
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
        uid: json["uid"] == null ? null : json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "resultMsg": resultMsg == null ? null : resultMsg,
        "resultCode": resultCode == null ? null : resultCode,
        "refreshToken": refreshToken == null ? null : refreshToken,
        "accessToken": accessToken == null ? null : accessToken,
        "uid": uid == null ? null : uid,
      };
}
