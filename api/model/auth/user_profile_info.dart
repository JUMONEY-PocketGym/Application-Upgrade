// To parse this JSON data, do
//
//     final userProfileInfoResponse = userProfileInfoResponseFromJson(jsonString);

import 'dart:convert';

UserProfileInfoResponse userProfileInfoResponseFromJson(String str) => UserProfileInfoResponse.fromJson(json.decode(str));

String userProfileInfoResponseToJson(UserProfileInfoResponse data) => json.encode(data.toJson());

class UserProfileInfoResponse {
  UserProfileInfoResponse({
    this.uid,
    this.email,
    this.name,
    this.addName,
    this.longitude,
    this.latitude,
    this.userProfile,
    this.userAccountInfor,
    this.booster,
    this.membership,
    this.wishListCount,
    this.reviewListCount,
    this.questionListCount,
  });

  int? uid;
  String? email;
  String? name;
  String? addName;
  double? longitude;
  double? latitude;
  UserProfile? userProfile;
  UserAccountInfor? userAccountInfor;
  int? booster;
  Membership? membership;
  int? wishListCount;
  int? reviewListCount;
  int? questionListCount;

  factory UserProfileInfoResponse.fromJson(Map<String, dynamic> json) => UserProfileInfoResponse(
        uid: json["uid"],
        email: json["email"],
        name: json["name"],
        addName: json["addName"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        userProfile: json["userProfile"] == null ? null : UserProfile.fromJson(json["userProfile"]),
        userAccountInfor: json["userAccountInfor"] == null ? null : UserAccountInfor.fromJson(json["userAccountInfor"]),
        booster: json["booster"],
        membership: json["membership"] == null ? null : Membership.fromJson(json["membership"]),
        wishListCount: json["wishListCount"],
        reviewListCount: json["reviewListCount"],
        questionListCount: json["questionListCount"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "addName": addName,
        "longitude": longitude,
        "latitude": latitude,
        "userProfile": userProfile?.toJson(),
        "userAccountInfor": userAccountInfor?.toJson(),
        "booster": booster,
        "membership": membership?.toJson(),
        "wishListCount": wishListCount,
        "reviewListCount": reviewListCount,
        "questionListCount": questionListCount,
      };
}

class Membership {
  Membership({
    this.activated,
    this.level,
    this.expiredAt,
  });

  bool? activated;
  int? level;
  String? expiredAt;

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        activated: json["activated"],
        level: json["level"],
        expiredAt: json["expiredAt"],
      );

  Map<String, dynamic> toJson() => {
        "activated": activated,
        "level": level,
        "expiredAt": expiredAt,
      };
}

class UserAccountInfor {
  UserAccountInfor({
    this.bankCode,
    this.bankAccountNumber,
    this.accountHolderName,
  });

  String? bankCode;
  String? bankAccountNumber;
  String? accountHolderName;

  factory UserAccountInfor.fromJson(Map<String, dynamic> json) => UserAccountInfor(
        bankCode: json["bankCode"],
        bankAccountNumber: json["bankAccountNumber"],
        accountHolderName: json["accountHolderName"],
      );

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "bankAccountNumber": bankAccountNumber,
        "accountHolderName": accountHolderName,
      };
}

class UserProfile {
  UserProfile({
    this.phoneNumber,
    this.nickName,
    this.profileImage,
    this.height,
    this.social,
    this.fitPoint,
    this.kcalPoint,
    this.lockedKcalPoint,
    this.lockedPoint,
    this.cashPoint,
    this.myRecordShaeringSetting,
    this.tokenAccount,
    this.walletPassword,
    this.gym,
  });

  String? phoneNumber;
  String? nickName;
  String? profileImage;
  int? height;
  int? social;
  int? fitPoint;
  int? kcalPoint;
  int? lockedKcalPoint;
  int? lockedPoint;
  int? cashPoint;
  bool? myRecordShaeringSetting;
  String? tokenAccount;
  String? walletPassword;
  dynamic gym;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        phoneNumber: json["phoneNumber"],
        nickName: json["nickName"],
        profileImage: json["profileImage"],
        height: json["height"],
        social: json["social"],
        fitPoint: json["fitPoint"],
        kcalPoint: json["kcalPoint"],
        lockedKcalPoint: json["lockedKcalPoint"],
        lockedPoint: json["lockedPoint"],
        cashPoint: json["cashPoint"],
        myRecordShaeringSetting: json["myRecordShaeringSetting"],
        tokenAccount: json["tokenAccount"],
        walletPassword: json["walletPassword"],
        gym: json["gym"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "nickName": nickName,
        "profileImage": profileImage,
        "height": height,
        "social": social,
        "fitPoint": fitPoint,
        "kcalPoint": kcalPoint,
        "lockedKcalPoint": lockedKcalPoint,
        "lockedPoint": lockedPoint,
        "cashPoint": cashPoint,
        "myRecordShaeringSetting": myRecordShaeringSetting,
        "tokenAccount": tokenAccount,
        "walletPassword": walletPassword,
        "gym": gym,
      };
}
