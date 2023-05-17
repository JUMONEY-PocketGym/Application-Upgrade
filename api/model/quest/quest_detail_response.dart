// To parse this JSON data, do
//
//     final qeustDetailResponse = qeustDetailResponseFromJson(jsonString);

import 'dart:convert';

QeustDetailResponse qeustDetailResponseFromJson(String str) => QeustDetailResponse.fromJson(json.decode(str));

String qeustDetailResponseToJson(QeustDetailResponse data) => json.encode(data.toJson());

class QeustDetailResponse {
  QeustDetailResponse({
    this.uid,
    this.title,
    this.description,
    this.isRelativeReward,
    this.isAllowPhotoShoot,
    this.isAllowVideoShoot,
    this.isAllowGallery,
    this.isAllowExerciseVideo,
    this.isAllowSamsungWalk,
    this.isAllowSamsungHeart,
    this.isAllowSamsungSleep,
    this.isAllowSamsungInbody,
    this.isLuckyDraw,
    this.categoryUid,
    this.type,
    this.joinPeriod,
    this.certificationRecordType,
    this.mobilizationStartTime,
    this.mobilizationEndTime,
    this.startTime,
    this.endTime,
    this.entryFee,
    this.certificationType,
    this.mobilizationLimit,
    this.entryFeType,
    this.compensationAmount,
    this.rewardType,
    this.image,
    this.engagementImage,
    this.isEnd,
    this.status,
    this.regDate,
    this.isConfirmed,
    this.accJoinCount,
    this.fakeJoinCount,
    this.accSuccessCount,
    this.accRewardKcal,
    this.reviewCount,
    this.periodInterval,
    this.intervalCount,
    this.recordCount,
    this.displayType,
    this.questType,
    this.tags,
    this.targetScore,
    this.dailyScoreLimit,
    this.totalReward,
    this.questReview,
    this.certification,
    this.questAlonePeriod,
    this.participation,
    this.joinUserList,
  });

  int? uid;
  String? title;
  String? description;
  bool? isRelativeReward;
  bool? isAllowPhotoShoot;
  bool? isAllowVideoShoot;
  bool? isAllowGallery;
  bool? isAllowExerciseVideo;
  bool? isAllowSamsungWalk;
  bool? isAllowSamsungHeart;
  bool? isAllowSamsungSleep;
  bool? isAllowSamsungInbody;
  bool? isLuckyDraw;
  String? categoryUid;
  int? type;
  int? joinPeriod;
  int? certificationRecordType;
  String? mobilizationStartTime;
  String? mobilizationEndTime;
  String? startTime;
  String? endTime;
  int? entryFee;
  int? certificationType;
  int? mobilizationLimit;
  int? entryFeType;
  int? compensationAmount;
  int? rewardType;
  String? image;
  String? engagementImage;
  int? isEnd;
  int? status;
  String? regDate;
  bool? isConfirmed;
  int? accJoinCount;
  int? fakeJoinCount;
  int? accSuccessCount;
  int? accRewardKcal;
  int? reviewCount;
  int? periodInterval;
  int? intervalCount;
  int? recordCount;
  String? displayType;
  String? questType;
  String? tags;
  int? targetScore;
  int? dailyScoreLimit;
  int? totalReward;
  List<QuestReview>? questReview;
  Certification? certification;
  List<QuestAlonePeriod>? questAlonePeriod;
  Participation? participation;
  List<JoinUserList>? joinUserList;

  factory QeustDetailResponse.fromJson(Map<String, dynamic> json) => QeustDetailResponse(
        uid: json["uid"],
        title: json["title"],
        description: json["description"],
        isRelativeReward: json["isRelativeReward"],
        isAllowPhotoShoot: json["isAllowPhotoShoot"],
        isAllowVideoShoot: json["isAllowVideoShoot"],
        isAllowGallery: json["isAllowGallery"],
        isAllowExerciseVideo: json["isAllowExerciseVideo"],
        isAllowSamsungWalk: json["isAllowSamsungWalk"],
        isAllowSamsungHeart: json["isAllowSamsungHeart"],
        isAllowSamsungSleep: json["isAllowSamsungSleep"],
        isAllowSamsungInbody: json["isAllowSamsungInbody"],
        isLuckyDraw: json["isLuckyDraw"],
        categoryUid: json["categoryUid"],
        type: json["type"],
        joinPeriod: json["joinPeriod"],
        certificationRecordType: json["certificationRecordType"],
        mobilizationStartTime: json["mobilizationStartTime"],
        mobilizationEndTime: json["mobilizationEndTime"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        entryFee: json["entryFee"],
        certificationType: json["certificationType"],
        mobilizationLimit: json["mobilizationLimit"],
        entryFeType: json["entryFeType"],
        compensationAmount: json["compensationAmount"],
        rewardType: json["rewardType"],
        image: json["image"],
        engagementImage: json["engagementImage"],
        isEnd: json["isEnd"],
        status: json["status"],
        regDate: json["regDate"],
        isConfirmed: json["isConfirmed"],
        accJoinCount: json["accJoinCount"],
        fakeJoinCount: json["fakeJoinCount"],
        accSuccessCount: json["accSuccessCount"],
        accRewardKcal: json["accRewardKcal"],
        reviewCount: json["reviewCount"],
        periodInterval: json["periodInterval"],
        intervalCount: json["intervalCount"],
        recordCount: json["recordCount"],
        displayType: json["displayType"],
        questType: json["questType"],
        tags: json["tags"],
        targetScore: json["targetScore"],
        dailyScoreLimit: json["dailyScoreLimit"],
        totalReward: json["totalReward"],
        questReview: json["questReview"] == null ? [] : List<QuestReview>.from(json["questReview"]!.map((x) => QuestReview.fromJson(x))),
        certification: json["certification"] == null ? null : Certification.fromJson(json["certification"]),
        questAlonePeriod: json["questAlonePeriod"] == null ? [] : List<QuestAlonePeriod>.from(json["questAlonePeriod"]!.map((x) => QuestAlonePeriod.fromJson(x))),
        participation: json["participation"] == null ? null : Participation.fromJson(json["participation"]),
        joinUserList: json["joinUserList"] == null ? [] : List<JoinUserList>.from(json["joinUserList"]!.map((x) => JoinUserList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "title": title,
        "description": description,
        "isRelativeReward": isRelativeReward,
        "isAllowPhotoShoot": isAllowPhotoShoot,
        "isAllowVideoShoot": isAllowVideoShoot,
        "isAllowGallery": isAllowGallery,
        "isAllowExerciseVideo": isAllowExerciseVideo,
        "isAllowSamsungWalk": isAllowSamsungWalk,
        "isAllowSamsungHeart": isAllowSamsungHeart,
        "isAllowSamsungSleep": isAllowSamsungSleep,
        "isAllowSamsungInbody": isAllowSamsungInbody,
        "isLuckyDraw": isLuckyDraw,
        "categoryUid": categoryUid,
        "type": type,
        "joinPeriod": joinPeriod,
        "certificationRecordType": certificationRecordType,
        "mobilizationStartTime": mobilizationStartTime,
        "mobilizationEndTime": mobilizationEndTime,
        "startTime": startTime,
        "endTime": endTime,
        "entryFee": entryFee,
        "certificationType": certificationType,
        "mobilizationLimit": mobilizationLimit,
        "entryFeType": entryFeType,
        "compensationAmount": compensationAmount,
        "rewardType": rewardType,
        "image": image,
        "engagementImage": engagementImage,
        "isEnd": isEnd,
        "status": status,
        "regDate": regDate,
        "isConfirmed": isConfirmed,
        "accJoinCount": accJoinCount,
        "fakeJoinCount": fakeJoinCount,
        "accSuccessCount": accSuccessCount,
        "accRewardKcal": accRewardKcal,
        "reviewCount": reviewCount,
        "periodInterval": periodInterval,
        "intervalCount": intervalCount,
        "recordCount": recordCount,
        "displayType": displayType,
        "questType": questType,
        "tags": tags,
        "targetScore": targetScore,
        "dailyScoreLimit": dailyScoreLimit,
        "totalReward": totalReward,
        "questReview": questReview == null ? [] : List<dynamic>.from(questReview!.map((x) => x.toJson())),
        "certification": certification?.toJson(),
        "questAlonePeriod": questAlonePeriod == null ? [] : List<dynamic>.from(questAlonePeriod!.map((x) => x.toJson())),
        "participation": participation?.toJson(),
        "joinUserList": joinUserList == null ? [] : List<dynamic>.from(joinUserList!.map((x) => x.toJson())),
      };
}

class Certification {
  Certification({
    this.ment,
    this.image,
  });

  String? ment;
  List<String>? image;

  factory Certification.fromJson(Map<String, dynamic> json) => Certification(
        ment: json["ment"],
        image: json["image"] == null ? [] : List<String>.from(json["image"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ment": ment,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
      };
}

class JoinUserList {
  JoinUserList({
    this.uid,
    this.pass,
    this.user,
    this.questRecord,
  });

  int? uid;
  int? pass;
  User? user;
  List<QuestRecord>? questRecord;

  factory JoinUserList.fromJson(Map<String, dynamic> json) => JoinUserList(
        uid: json["uid"],
        pass: json["pass"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        questRecord: json["questRecord"] == null ? [] : List<QuestRecord>.from(json["questRecord"]!.map((x) => QuestRecord.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "pass": pass,
        "user": user?.toJson(),
        "questRecord": questRecord == null ? [] : List<dynamic>.from(questRecord!.map((x) => x.toJson())),
      };
}

class QuestRecord {
  QuestRecord({
    this.source,
    this.recordType,
    this.turn,
    this.userProfile,
    this.userNickname,
  });

  String? source;
  int? recordType;
  int? turn;
  String? userProfile;
  String? userNickname;

  factory QuestRecord.fromJson(Map<String, dynamic> json) => QuestRecord(
        source: json["source"],
        recordType: json["recordType"],
        turn: json["turn"],
        userProfile: json["userProfile"],
        userNickname: json["userNickname"],
      );

  Map<String, dynamic> toJson() => {
        "source": source,
        "recordType": recordType,
        "turn": turn,
        "userProfile": userProfile,
        "userNickname": userNickname,
      };
}

class User {
  User({
    this.uid,
    this.userProfile,
  });

  int? uid;
  UserProfile? userProfile;

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        userProfile: json["userProfile"] == null ? null : UserProfile.fromJson(json["userProfile"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "userProfile": userProfile?.toJson(),
      };
}

class UserProfile {
  UserProfile({
    this.nickName,
    this.profileImage,
  });

  String? nickName;
  String? profileImage;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        nickName: json["nickName"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "nickName": nickName,
        "profileImage": profileImage,
      };
}

class Participation {
  Participation({
    this.purchase,
    this.booster,
    this.validStartDate,
    this.validEndDate,
    this.activeDate,
    this.isMembership,
    this.userLevel,
    this.myQuestRecord,
    this.pass,
    this.questParticipationUserUid,
  });

  bool? purchase;
  int? booster;
  String? validStartDate;
  String? validEndDate;
  String? activeDate;
  bool? isMembership;
  int? userLevel;
  int? pass;
  List<MyQuestRecord>? myQuestRecord;
  int? questParticipationUserUid;

  factory Participation.fromJson(Map<String, dynamic> json) => Participation(
        purchase: json["purchase"],
        booster: json["booster"],
        validStartDate: json["validStartDate"],
        validEndDate: json["validEndDate"],
        activeDate: json["activeDate"],
        isMembership: json["isMembership"],
        userLevel: json["userLevel"],
        pass: json["pass"],
        myQuestRecord: json["myQuestRecord"] == null ? [] : List<MyQuestRecord>.from(json["myQuestRecord"]!.map((x) => MyQuestRecord.fromJson(x))),
        questParticipationUserUid: json["questParticipationUserUid"],
      );

  Map<String, dynamic> toJson() => {
        "purchase": purchase,
        "booster": booster,
        "validStartDate": validStartDate,
        "validEndDate": validEndDate,
        "activeDate": activeDate,
        "isMembership": isMembership,
        "userLevel": userLevel,
        "pass": pass,
        "myQuestRecord": myQuestRecord == null ? [] : List<dynamic>.from(myQuestRecord!.map((x) => x.toJson())),
        "questParticipationUserUid": questParticipationUserUid,
      };
}

class QuestAlonePeriod {
  QuestAlonePeriod({
    this.id,
    this.startAddDays,
    this.endAddDays,
    this.exerciseVideo,
  });

  int? id;
  int? startAddDays;
  int? endAddDays;
  String? exerciseVideo;

  factory QuestAlonePeriod.fromJson(Map<String, dynamic> json) => QuestAlonePeriod(
        id: json["id"],
        startAddDays: json["startAddDays"],
        endAddDays: json["endAddDays"],
        exerciseVideo: json["exerciseVideo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startAddDays": startAddDays,
        "endAddDays": endAddDays,
        "exerciseVideo": exerciseVideo,
      };
}

class QuestReview {
  QuestReview({
    this.userUid,
    this.userNickname,
    this.userProfile,
    this.content,
    this.feedOpenDate,
    this.images,
  });

  int? userUid;
  String? userNickname;
  String? userProfile;
  String? content;
  String? feedOpenDate;
  String? images;

  factory QuestReview.fromJson(Map<String, dynamic> json) => QuestReview(
        userUid: json["userUid"],
        userNickname: json["userNickname"],
        userProfile: json["userProfile"],
        content: json["content"],
        feedOpenDate: json["feedOpenDate"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "userUid": userUid,
        "userNickname": userNickname,
        "userProfile": userProfile,
        "content": content,
        "feedOpenDate": feedOpenDate,
        "images": images,
      };
}

class MyQuestRecord {
  MyQuestRecord({
    this.uid,
    this.source,
    this.content,
    this.recordType,
    this.questType,
    this.turn,
    this.userProfile,
    this.userNickname,
    this.regDate,
    this.uploadStatus,
  });

  int? uid;
  String? source;
  dynamic content;
  int? recordType;
  String? questType;
  int? turn;
  String? userProfile;
  String? userNickname;
  String? regDate;
  String? uploadStatus;

  factory MyQuestRecord.fromJson(Map<String, dynamic> json) => MyQuestRecord(
        uid: json["uid"],
        source: json["source"],
        content: json["content"],
        recordType: json["recordType"],
        questType: json["questType"],
        turn: json["turn"],
        userProfile: json["userProfile"],
        userNickname: json["userNickname"],
        regDate: json["regDate"],
        uploadStatus: json["uploadStatus"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "source": source,
        "content": content,
        "recordType": recordType,
        "questType": questType,
        "turn": turn,
        "userProfile": userProfile,
        "userNickname": userNickname,
        "regDate": regDate,
        "uploadStatus": uploadStatus,
      };
}
