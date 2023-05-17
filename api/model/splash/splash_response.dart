// To parse this JSON data, do
//
//     final splashDataResponse = splashDataResponseFromJson(jsonString);

import 'dart:convert';

SplashDataResponse splashDataResponseFromJson(String str) => SplashDataResponse.fromJson(json.decode(str));

String splashDataResponseToJson(SplashDataResponse data) => json.encode(data.toJson());

class SplashDataResponse {
  SplashDataResponse({
    this.uid,
    this.bannerUseCurriculum,
    this.bannerUsePoint,
    this.bannerResultBetting,
    this.commissionRatio,
    this.totalRewardAct,
    this.monthRewardAct,
    this.minUseKcal,
    this.type1TrainerIncomeRatio,
    this.type1GymIncomeRatio,
    this.type1CompanyIncomeRatio,
    this.type2TrainerIncomeRatio,
    this.type2GymIncomeRatio,
    this.type2CompanyIncomeRatio,
    this.type3TrainerIncomeRatio,
    this.type3GymIncomeRatio,
    this.type3CompanyIncomeRatio,
    this.type4TrainerIncomeRatio,
    this.type4GymIncomeRatio,
    this.type4CompanyIncomeRatio,
    this.actToKrw,
    this.pptToKrw,
    this.pptToAct,
    this.actToPpt,
    this.actToPptFeeRate,
    this.actToKrwFeeRate,
    this.companyName,
    this.companyInfo,
    this.introPageImages,
    this.todayWithdrawal,
    this.mainBanners,
  });

  int? uid;
  String? bannerUseCurriculum;
  String? bannerUsePoint;
  String? bannerResultBetting;
  double? commissionRatio;
  int? totalRewardAct;
  int? monthRewardAct;
  int? minUseKcal;
  double? type1TrainerIncomeRatio;
  double? type1GymIncomeRatio;
  double? type1CompanyIncomeRatio;
  double? type2TrainerIncomeRatio;
  double? type2GymIncomeRatio;
  double? type2CompanyIncomeRatio;
  double? type3TrainerIncomeRatio;
  double? type3GymIncomeRatio;
  double? type3CompanyIncomeRatio;
  double? type4TrainerIncomeRatio;
  double? type4GymIncomeRatio;
  double? type4CompanyIncomeRatio;
  int? actToKrw;
  int? pptToKrw;
  int? pptToAct;
  double? actToPpt;
  double? actToPptFeeRate;
  double? actToKrwFeeRate;
  String? companyName;
  String? companyInfo;
  List<String>? introPageImages;
  List<TodayWithdrawal>? todayWithdrawal;
  List<MainBanner>? mainBanners;

  factory SplashDataResponse.fromJson(Map<String, dynamic> json) => SplashDataResponse(
        uid: json["uid"],
        bannerUseCurriculum: json["bannerUseCurriculum"],
        bannerUsePoint: json["bannerUsePoint"],
        bannerResultBetting: json["bannerResultBetting"],
        commissionRatio: json["commissionRatio"]?.toDouble(),
        totalRewardAct: json["totalRewardAct"],
        monthRewardAct: json["monthRewardAct"],
        minUseKcal: json["minUseKcal"],
        type1TrainerIncomeRatio: json["type1TrainerIncomeRatio"]?.toDouble(),
        type1GymIncomeRatio: json["type1GymIncomeRatio"]?.toDouble(),
        type1CompanyIncomeRatio: json["type1CompanyIncomeRatio"]?.toDouble(),
        type2TrainerIncomeRatio: json["type2TrainerIncomeRatio"]?.toDouble(),
        type2GymIncomeRatio: json["type2GymIncomeRatio"]?.toDouble(),
        type2CompanyIncomeRatio: json["type2CompanyIncomeRatio"]?.toDouble(),
        type3TrainerIncomeRatio: json["type3TrainerIncomeRatio"]?.toDouble(),
        type3GymIncomeRatio: json["type3GymIncomeRatio"]?.toDouble(),
        type3CompanyIncomeRatio: json["type3CompanyIncomeRatio"]?.toDouble(),
        type4TrainerIncomeRatio: json["type4TrainerIncomeRatio"]?.toDouble(),
        type4GymIncomeRatio: json["type4GymIncomeRatio"]?.toDouble(),
        type4CompanyIncomeRatio: json["type4CompanyIncomeRatio"]?.toDouble(),
        actToKrw: json["actToKrw"],
        pptToKrw: json["pptToKrw"],
        pptToAct: json["pptToAct"],
        actToPpt: json["actToPpt"]?.toDouble(),
        actToPptFeeRate: json["actToPptFeeRate"]?.toDouble(),
        actToKrwFeeRate: json["actToKrwFeeRate"]?.toDouble(),
        companyName: json["companyName"],
        companyInfo: json["companyInfo"],
        introPageImages: json["introPageImages"] == null ? [] : List<String>.from(json["introPageImages"]!.map((x) => x)),
        todayWithdrawal: json["todayWithdrawal"] == null ? [] : List<TodayWithdrawal>.from(json["todayWithdrawal"]!.map((x) => TodayWithdrawal.fromJson(x))),
        mainBanners: json["mainBanners"] == null ? [] : List<MainBanner>.from(json["mainBanners"]!.map((x) => MainBanner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "bannerUseCurriculum": bannerUseCurriculum,
        "bannerUsePoint": bannerUsePoint,
        "bannerResultBetting": bannerResultBetting,
        "commissionRatio": commissionRatio,
        "totalRewardAct": totalRewardAct,
        "monthRewardAct": monthRewardAct,
        "minUseKcal": minUseKcal,
        "type1TrainerIncomeRatio": type1TrainerIncomeRatio,
        "type1GymIncomeRatio": type1GymIncomeRatio,
        "type1CompanyIncomeRatio": type1CompanyIncomeRatio,
        "type2TrainerIncomeRatio": type2TrainerIncomeRatio,
        "type2GymIncomeRatio": type2GymIncomeRatio,
        "type2CompanyIncomeRatio": type2CompanyIncomeRatio,
        "type3TrainerIncomeRatio": type3TrainerIncomeRatio,
        "type3GymIncomeRatio": type3GymIncomeRatio,
        "type3CompanyIncomeRatio": type3CompanyIncomeRatio,
        "type4TrainerIncomeRatio": type4TrainerIncomeRatio,
        "type4GymIncomeRatio": type4GymIncomeRatio,
        "type4CompanyIncomeRatio": type4CompanyIncomeRatio,
        "actToKrw": actToKrw,
        "pptToKrw": pptToKrw,
        "pptToAct": pptToAct,
        "actToPpt": actToPpt,
        "actToPptFeeRate": actToPptFeeRate,
        "actToKrwFeeRate": actToKrwFeeRate,
        "companyName": companyName,
        "companyInfo": companyInfo,
        "introPageImages": introPageImages == null ? [] : List<dynamic>.from(introPageImages!.map((x) => x)),
        "todayWithdrawal": todayWithdrawal == null ? [] : List<dynamic>.from(todayWithdrawal!.map((x) => x.toJson())),
        "mainBanners": mainBanners == null ? [] : List<dynamic>.from(mainBanners!.map((x) => x.toJson())),
      };
}

class MainBanner {
  MainBanner({
    this.fileAdress,
    this.targetPath,
    this.targetOption,
  });

  String? fileAdress;
  String? targetPath;
  dynamic targetOption;

  factory MainBanner.fromJson(Map<String, dynamic> json) => MainBanner(
        fileAdress: json["fileAdress"],
        targetPath: json["targetPath"],
        targetOption: json["targetOption"],
      );

  Map<String, dynamic> toJson() => {
        "fileAdress": fileAdress,
        "targetPath": targetPath,
        "targetOption": targetOption,
      };
}

class TodayWithdrawal {
  TodayWithdrawal({
    this.username,
    this.depositKrw,
    this.regDate,
  });

  String? username;
  int? depositKrw;
  String? regDate;

  factory TodayWithdrawal.fromJson(Map<String, dynamic> json) => TodayWithdrawal(
        username: json["username"],
        depositKrw: json["depositKRW"],
        regDate: json["regDate"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "depositKRW": depositKrw,
        "regDate": regDate,
      };
}
