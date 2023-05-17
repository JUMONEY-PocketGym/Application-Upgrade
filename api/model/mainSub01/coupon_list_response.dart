// To parse this JSON data, do
//
//     final couponListResponse = couponListResponseFromJson(jsonString);

import 'dart:convert';

List<CouponListResponse> couponListResponseFromJson(String str) => List<CouponListResponse>.from(json.decode(str).map((x) => CouponListResponse.fromJson(x)));

String couponListResponseToJson(List<CouponListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CouponListResponse {
  CouponListResponse({
    this.uid,
    this.status,
    this.endDate,
    this.couponIssueHistory,
  });

  int? uid;
  int? status;
  String? endDate;
  CouponIssueHistory? couponIssueHistory;

  factory CouponListResponse.fromJson(Map<String, dynamic> json) => CouponListResponse(
        uid: json["uid"] == null ? null : json["uid"],
        status: json["status"] == null ? null : json["status"],
        endDate: json["endDate"] == null ? null : json["endDate"],
        couponIssueHistory: json["couponIssueHistory"] == null ? null : CouponIssueHistory.fromJson(json["couponIssueHistory"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "status": status == null ? null : status,
        "endDate": endDate == null ? null : endDate,
        "couponIssueHistory": couponIssueHistory == null ? null : couponIssueHistory!.toJson(),
      };
}

class CouponIssueHistory {
  CouponIssueHistory({
    this.uid,
    this.coupon,
  });

  int? uid;
  Coupon? coupon;

  factory CouponIssueHistory.fromJson(Map<String, dynamic> json) => CouponIssueHistory(
        uid: json["uid"] == null ? null : json["uid"],
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "coupon": coupon == null ? null : coupon!.toJson(),
      };
}

class Coupon {
  Coupon({
    this.uid,
    this.name,
    this.type,
    this.discountType,
    this.amount,
    this.status,
  });

  int? uid;
  String? name;
  int? type;
  int? discountType;
  int? amount;
  int? status;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        uid: json["uid"] == null ? null : json["uid"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        discountType: json["discountType"] == null ? null : json["discountType"],
        amount: json["amount"] == null ? null : json["amount"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "discountType": discountType == null ? null : discountType,
        "amount": amount == null ? null : amount,
        "status": status == null ? null : status,
      };
}
