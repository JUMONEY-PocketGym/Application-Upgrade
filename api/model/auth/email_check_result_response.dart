// To parse this JSON data, do
//
//     final emailCheckResultResponse = emailCheckResultResponseFromJson(jsonString);

import 'dart:convert';

EmailCheckResultResponse emailCheckResultResponseFromJson(String str) => EmailCheckResultResponse.fromJson(json.decode(str));

String emailCheckResultResponseToJson(EmailCheckResultResponse data) => json.encode(data.toJson());

class EmailCheckResultResponse {
  EmailCheckResultResponse({
    this.result,
    this.resultCode,
    this.resultMsg,
  });

  String? result;
  int? resultCode;
  String? resultMsg;

  factory EmailCheckResultResponse.fromJson(Map<String, dynamic> json) => EmailCheckResultResponse(
        result: json["result"] == null ? null : json["result"],
        resultCode: json["resultCode"] == null ? null : json["resultCode"],
        resultMsg: json["resultMsg"] == null ? null : json["resultMsg"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "resultCode": resultCode == null ? null : resultCode,
        "resultMsg": resultMsg == null ? null : resultMsg,
      };
}
