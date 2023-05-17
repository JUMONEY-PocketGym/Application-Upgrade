import 'dart:convert';

class SignupReq {
  //일반 로그인
  //이메일
  //비밀번호
  //실명
  //핸드폰 번호
  //성별
  //통신사
  //생년월일
  //닉네임
  //키
  //소속 헬스장 유무 0: 없음 1: 있음
  //헬스장 uid
  //소셜 타입
  //추천인 유무 0:없음 1:유자 2:트레이너
  //추친인 uid
  ///소셜 로그인
  ///프로필 이미지
  ///소셜 코드
  //핸드폰 고유키
  // 앱-핸드폰 고유키
  // 외국인 여부
  // 정보 혜택 수신 동의
  SignupReq(
      {this.udid,
      this.email,
      this.password,
      this.name,
      this.phoneNumber,
      this.gender,
      this.newsAgency,
      this.birthDate,
      this.nickName,
      this.height,
      this.existGym,
      this.gymUid,
      this.socialType,
      this.existRecommendPerson,
      this.recommendPersonUid,
      this.profileImage,
      this.socialCode,
      this.uniqueKey,
      this.uniqueInSite,
      this.foreigner,
      this.eventAlarm,
      this.isInviteLink,
      this.addName,
      this.longitude,
      this.latitude});

  String? udid;
  String? email;
  String? password;
  String? name;
  String? phoneNumber;
  int? gender;
  String? newsAgency;
  String? birthDate;
  String? nickName;
  double? height;
  int? existGym;
  int? gymUid;
  int? socialType;
  int? existRecommendPerson;
  int? recommendPersonUid;
  String? profileImage;
  String? socialCode;

  String? uniqueKey;
  String? uniqueInSite;
  bool? foreigner;
  bool? eventAlarm;
  bool? isInviteLink;
  String? addName;
  double? longitude;
  double? latitude;

  factory SignupReq.fromRawJson(String str) => SignupReq.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignupReq.fromJson(Map<String, dynamic> json) => SignupReq(
        udid: json["udid"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        gender: json["gender"],
        newsAgency: json["newsAgency"],
        birthDate: json["birthDate"],
        nickName: json["nickName"],
        height: json["height"],
        existGym: json["existGym"],
        gymUid: json["gymUid"],
        socialType: json["socialType"],
        existRecommendPerson: json["existRecommendPerson"],
        recommendPersonUid: json["recommendPersonUid"],
        profileImage: json["profileImage"],
        socialCode: json["socialCode"],
        uniqueKey: json["uniqueKey"],
        uniqueInSite: json["uniqueInSite"],
        foreigner: json["foreigner"],
        addName: json["addName"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        eventAlarm: json["eventAlarm"],
        isInviteLink: json["isInviteLink"],
      );

  Map<String, dynamic> toJson() => {
        "udid": udid,
        "email": email,
        "password": password,
        "name": name,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "newsAgency": newsAgency,
        "birthDate": birthDate,
        "nickName": nickName,
        "height": height,
        "existGym": existGym,
        "gymUid": gymUid,
        "socialType": socialType,
        "existRecommendPerson": existRecommendPerson,
        "recommendPersonUid": recommendPersonUid,
        "profileImage": profileImage,
        "socialCode": socialCode,
        "uniqueKey": uniqueKey,
        "uniqueInSite": uniqueInSite,
        "foreigner": foreigner,
        "addName": addName,
        "longitude": longitude,
        "latitude": latitude,
        "eventAlarm": eventAlarm,
        "isInviteLink": isInviteLink,
      };
}
