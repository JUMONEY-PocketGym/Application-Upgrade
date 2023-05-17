import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pock_gym/api/apiVal.dart';
import 'package:pock_gym/api/model/auth/auth_sns_user_check_response.dart';
import 'package:pock_gym/api/model/auth/email_check_result_response.dart';
import 'package:pock_gym/api/model/auth/invite_check_user_result_response.dart';
import 'package:pock_gym/api/model/auth/user_profile_info.dart';
import 'package:pock_gym/api/model/mainSub01/coupon_list_response.dart';
import 'package:pock_gym/api/model/mainSub01/my_quest_list_response.dart';
import 'package:pock_gym/api/model/quest/quest_detail_response.dart';
import 'package:pock_gym/api/model/quest/quest_list_response.dart';
import 'package:pock_gym/api/model/splash/splash_response.dart';
import 'package:pock_gym/ui/intro/splash/controller/splash_controller.dart';
import 'package:pock_gym/ui/mainPage/notificationList/model/notification_list_response.dart';
import 'package:pock_gym/ui/mainPage/subPage/customerCenter/faq/controller/model/faq_list_response.dart';
import 'package:pock_gym/ui/mainPage/subPage/customerCenter/question/model/question_list_response.dart';
import 'package:pock_gym/ui/mainPage/subPage/myPage/model/deposit_response.dart';
import 'package:pock_gym/ui/mainPage/subPage/myPage/model/token_response.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/buyQuest/model/qeust_period_check_response.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage02/sub/model/best_review_list_response.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage02/sub/model/notice_response.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage03/model/my_quest_list_response.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage04/model/records_list_response.dart';
import 'package:pock_gym/ui/mainPage/subPage/terms/model/terms_response.dart';
import 'package:pock_gym/ui/widthraw/widthrawCash/model/point_list_response.dart';
import 'package:pock_gym/utils/debug_print.dart';

class RemoteServiceGet {
  static var client = http.Client();

  static Future<EmailCheckResultResponse?> checkEmail(String email) async {
    String apiUrlPath = apiURL + "users/check/email/$email";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("checkEmail Response :: " + apiUrlPath);
    print("checkEmail Response :: " + result);
    return response.statusCode < 400 ? emailCheckResultResponseFromJson(result) : null;
  }

  static Future<EmailCheckResultResponse?> checkNickName(String nickName) async {
    String apiUrlPath = apiURL + "users/check/nickname/$nickName";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("checkNickName Response :: " + apiUrlPath);
    print("checkNickName Response :: " + result);
    return response.statusCode < 400 ? emailCheckResultResponseFromJson(result) : null;
  }

  static Future<InviteCheckUserResultResponse?> checkInviteUser(String type, String keyword) async {
    String apiUrlPath;

    if (type == "user") {
      apiUrlPath = apiURL + "users/validate-nickname/$keyword";
    } else {
      apiUrlPath = apiURL + "trainers/validate-name/$keyword";
    }

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("checkInviteUser Response :: " + apiUrlPath);
    print("checkInviteUser Response :: " + result);
    return response.statusCode < 400 ? inviteCheckUserResultResponseFromJson(result) : null;
  }

  static Future<SplashDataResponse?> getSplashData(String uid) async {
    String apiUrlPath = apiURL + "splash";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    dPrint("getSplashData Response :: " + result);
    return response.statusCode < 400 ? splashDataResponseFromJson(result) : null;
  }

  static Future<UserProfileInfoResponse?> getUserProfileInfo(String uid) async {
    String apiUrlPath = apiURL + "users/profile";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    dPrint("UserProfileInfo Response :: " + result);
    return response.statusCode < 400 ? userProfileInfoResponseFromJson(result) : null;
  }

  static Future<List<FaQListResponse>?> getFaQList(String uid) async {
    String apiUrlPath = apiURL + "other/faq";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getFaQList Response :: " + apiUrlPath);
    dPrint("getFaQList Response :: " + result);
    return response.statusCode < 400 ? faQListResponseFromJson(result) : null;
  }

  static Future<List<QuestionListResponse>?> getQuestionList(String uid) async {
    String apiUrlPath = apiURL + "other/question";

    // var header = {"uid": "493"};
    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getQuestionList Response :: " + apiUrlPath);
    print("getQuestionList Response :: " + result);
    return response.statusCode < 400 ? questionListResponseFromJson(result) : null;
  }

  static Future<TermsResponse?> getTerms() async {
    String apiUrlPath = apiURL + "terms";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("getTerms Response :: " + apiUrlPath);
    print("getTerms Response :: " + result);
    return response.statusCode < 400 ? termsResponseFromJson(result) : null;
  }

  static Future<QuestListResponse?> getQuestList() async {
    String apiUrlPath = apiURL + "quest/list/progress";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("getTerms Response :: " + apiUrlPath);
    print("getQuestList Response :: " + result);
    return response.statusCode < 400 ? questListResponseFromJson(result) : null;
  }

  static Future<AuthSnsUserCheckResponse?> checkSnsLoginUser(var data) async {
    String apiUrlPath = apiURL + "auth/social/check";

    var header = {
      "Content-Type": "application/json",
    };
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("checkSnsLoginUser :: " + result);
    return response.statusCode < 400 ? authSnsUserCheckResponseFromJson(result) : null;
  }

  static Future<QeustDetailResponse?> getQuesDetail(String uid, String idx) async {
    String apiUrlPath = apiURL + "quest/view/$idx";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getQuesDetail Response :: " + apiUrlPath);
    dPrint("getQuesDetail Response :: " + result);
    return response.statusCode < 400 ? qeustDetailResponseFromJson(result) : null;
  }

  static Future<QeustDetailResponse?> getQuesDetailEnd(String uid, String idx) async {
    String apiUrlPath = apiURL + "quest/complete-view/$idx";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getQuesDetail Response :: " + apiUrlPath);
    dPrint("getQuesDetail Response :: " + result);
    return response.statusCode < 400 ? qeustDetailResponseFromJson(result) : null;
  }

  static recordExerciseUpload(String uid, dynamic data) async {
    String apiUrlPath = apiURL + "records/exercise";

    var header = {"Content-Type": "application/json", "uid": uid};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("recordExerciseUpload Response :: " + result);
    return response.statusCode < 400 ? result : null;
  }

  static Future<List<MyQuestListResponse>?> myQuestList(String uid) async {
    String apiUrlPath = apiURL + "quest/my";

    var header = {"Content-Type": "application/json", "uid": uid};
    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    dPrint("myQuestList Response :: " + result);
    return response.statusCode < 400 ? myQuestListResponseFromJson(result) : null;
  }

  static Future<List<RecordsListResponse>?> getRecords(String uid, String page) async {
    String apiUrlPath = apiURL + "records/list/$page";

    var header = {"Content-Type": "application/json", "uid": uid};
    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getRecords Response :: " + result);
    return response.statusCode < 400 ? recordsListResponseFromJson(result) : null;
  }

  static Future<List<QuestPeriodCheckResponse>?> getQuestSchedule(
    String uid,
  ) async {
    String apiUrlPath = apiURL + "quest/schedule/$uid";

    var header = {"Content-Type": "application/json", "uid": uid};
    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getRecords Response :: " + result);
    return response.statusCode < 400 ? questPeriodCheckResponseFromJson(result) : null;
  }

  static Future<List<CouponListResponse>?> getCouponList(String uid, String trainerUid, String type) async {
    String apiUrlPath = apiURL + "coupons?type=$type&trainerUid=$trainerUid";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getCouponList Response :: " + apiUrlPath);
    print("getCouponList Response :: " + result);
    return response.statusCode < 400 ? couponListResponseFromJson(result) : null;
  }

  static getMyQeustList() async {
    SplashController sc = Get.find();
    var uid = sc.userProfileInfo.value.uid.toString();
    String apiUrlPath = apiURL + "quest/schedule-uid/$uid";

    var header = {"Content-Type": "application/json", "uid": uid};
    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("MyQuest Response :: " + result);
    return response.statusCode < 400 ? myQeustListResponseFromJson(result) : null;
  }

  static Future<List<BestReviewListResponse>?> getBestReview() async {
    String apiUrlPath = apiURL + "other/best-review/1/99999";

    SplashController sc = Get.find();
    var uid = sc.userProfileInfo.value.uid.toString();
    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getCouponList Response :: " + apiUrlPath);
    print("getCouponList Response :: " + result);
    return response.statusCode < 400 ? bestReviewListResponseFromJson(result) : null;
  }

  static getIvCnt() async {
    String apiUrlPath = apiURL + "users/today-invite";

    SplashController sc = Get.find();
    var uid = sc.userProfileInfo.value.uid.toString();
    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getIvCnt Response :: " + apiUrlPath);
    dPrint("getIvCnt Response :: " + result);
    return response.statusCode < 400 ? result : null;
  }

  static Future<NoticeResponse?> getNotice() async {
    String apiUrlPath = apiURL + "feeds/list/1/9999";

    SplashController sc = Get.find();
    var uid = sc.userProfileInfo.value.uid.toString();
    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getNotice Response :: " + apiUrlPath);
    print("getNotice Response :: " + result);
    return response.statusCode < 400 ? noticeResponseFromJson(result) : null;
  }

  static Future<TokenResponse?> getTokenData(var tokenAccount) async {
    String apiUrlPath = "https://pocket-pay.net/api/v1/token/balance/$tokenAccount";

    SplashController sc = Get.find();
    var uid = sc.userProfileInfo.value.uid.toString();
    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getNotice Response :: " + apiUrlPath);
    print("getNotice Response :: " + result);
    return response.statusCode < 400 ? tokenResponseFromJson(result) : null;
  }

  static Future<DepositResponse?> checkDeposit(var tokenAccount) async {
    String apiUrlPath = "https://pocket-pay.net/api/v1/token/check_deposit/$tokenAccount";

    SplashController sc = Get.find();
    var uid = sc.userProfileInfo.value.uid.toString();
    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    // print("getNotice Response :: " + apiUrlPath);
    print("checkDeposit :: " + result);
    return response.statusCode < 400 ? depositResponseFromJson(result) : null;
  }

  static Future<List<PointListResponse>?> getPointList(String uid, int pointType) async {
    String apiUrlPath = apiURL + "point/fitpoint/record-list/?pointType=$pointType";
    // String apiUrlPath =
    //     apiURL + "point/fitpoint/record?recordType=0&pointType=0";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getPointList Response :: " + apiUrlPath);
    print("getPointList Response :: " + result);
    return response.statusCode < 400 ? pointListResponseFromJson(result) : null;
  }

  static Future<List<NotificationListResponse>?> getNotificationList(String uid) async {
    String apiUrlPath = apiURL + "push-message/user-history";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getNotificationList Response :: " + apiUrlPath);
    print("getNotificationList Response :: " + result);
    return response.statusCode < 400 ? notificationListResponseFromJson(result) : null;
  }
}
