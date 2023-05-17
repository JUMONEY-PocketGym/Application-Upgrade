// To parse this JSON data, do
//
//     final questListResponse = questListResponseFromJson(jsonString);

import 'dart:convert';

QuestListResponse questListResponseFromJson(String str) => QuestListResponse.fromJson(json.decode(str));

String questListResponseToJson(QuestListResponse data) => json.encode(data.toJson());

class QuestListResponse {
  QuestListResponse({
    this.categoryList,
    this.questList,
  });

  List<CategoryList>? categoryList;
  List<QuestList>? questList;

  factory QuestListResponse.fromJson(Map<String, dynamic> json) => QuestListResponse(
        categoryList: json["categoryList"] == null ? null : List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
        questList: json["questList"] == null ? null : List<QuestList>.from(json["questList"].map((x) => QuestList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryList": categoryList == null ? null : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
        "questList": questList == null ? null : List<dynamic>.from(questList!.map((x) => x.toJson())),
      };
}

class CategoryList {
  CategoryList({
    this.uid,
    this.title,
    this.questType,
  });

  String? uid;
  String? title;
  String? questType;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        uid: json["uid"] == null ? null : json["uid"],
        title: json["title"] == null ? null : json["title"],
        questType: json["questType"] == null ? null : json["questType"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "title": title == null ? null : title,
        "questType": questType == null ? null : questType,
      };
}

class QuestList {
  QuestList({
    this.uid,
    this.title,
    this.mobilizationEndTime,
    this.compensationAmount,
    this.image,
    this.mobilizationLimit,
    this.accJoinCount,
    this.fakeJoinCount,
    this.questType,
    this.displayType,
    this.categoryUid,
    this.tags,
    this.entryFee,
    this.isLuckyDraw,
  });

  int? uid;
  String? title;
  String? mobilizationEndTime;
  int? compensationAmount;
  int? entryFee;
  String? image;
  int? mobilizationLimit;
  int? accJoinCount;
  int? fakeJoinCount;
  String? questType;
  String? displayType;
  String? categoryUid;
  String? tags;
  bool? isLuckyDraw;

  factory QuestList.fromJson(Map<String, dynamic> json) => QuestList(
        uid: json["uid"] == null ? null : json["uid"],
        title: json["title"] == null ? null : json["title"],
        mobilizationEndTime: json["mobilizationEndTime"] == null ? null : json["mobilizationEndTime"],
        compensationAmount: json["compensationAmount"] == null ? null : json["compensationAmount"],
        entryFee: json["entryFee"] == null ? null : json["entryFee"],
        image: json["image"] == null ? null : json["image"],
        mobilizationLimit: json["mobilizationLimit"] == null ? null : json["mobilizationLimit"],
        accJoinCount: json["accJoinCount"] == null ? null : json["accJoinCount"],
        fakeJoinCount: json["fakeJoinCount"] == null ? null : json["fakeJoinCount"],
        questType: json["questType"] == null ? null : json["questType"],
        displayType: json["displayType"] == null ? null : json["displayType"],
        categoryUid: json["categoryUid"] == null ? null : json["categoryUid"],
        tags: json["tags"] == null ? null : json["tags"],
        isLuckyDraw: json["isLuckyDraw"] == null ? null : json["isLuckyDraw"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "title": title == null ? null : title,
        "mobilizationEndTime": mobilizationEndTime == null ? null : mobilizationEndTime,
        "compensationAmount": compensationAmount == null ? null : compensationAmount,
        "entryFee": entryFee == null ? null : entryFee,
        "image": image == null ? null : image,
        "mobilizationLimit": mobilizationLimit == null ? null : mobilizationLimit,
        "accJoinCount": accJoinCount == null ? null : accJoinCount,
        "fakeJoinCount": fakeJoinCount == null ? null : fakeJoinCount,
        "questType": questType == null ? null : questType,
        "displayType": displayType == null ? null : displayType,
        "categoryUid": categoryUid == null ? null : categoryUid,
        "tags": tags == null ? null : tags,
        "isLuckyDraw": isLuckyDraw == null ? null : isLuckyDraw,
      };
}
