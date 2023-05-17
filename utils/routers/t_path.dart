import 'dart:convert';

import 'package:get/get.dart';
import 'package:pock_gym/api/model/main02/best_review_model.dart';
import 'package:pock_gym/ui/auth/emailRegister/email_register_page.dart';
import 'package:pock_gym/ui/auth/login/login_page.dart';
import 'package:pock_gym/ui/intro/onBoarding/onboarding_root_page.dart';
import 'package:pock_gym/ui/intro/splash/controller/splash_controller.dart';
import 'package:pock_gym/ui/mainPage/controller/main_controller.dart';
import 'package:pock_gym/ui/mainPage/main_page_root.dart';
import 'package:pock_gym/ui/mainPage/subPage/couponList/coupon_list.dart';
import 'package:pock_gym/ui/mainPage/subPage/customerCenter/customer_center.dart';
import 'package:pock_gym/ui/mainPage/subPage/customerCenter/faq/faq_page.dart';
import 'package:pock_gym/ui/mainPage/subPage/customerCenter/question/question_page.dart';
import 'package:pock_gym/ui/mainPage/subPage/depositKcal/deposit_kcal.dart';
import 'package:pock_gym/ui/mainPage/subPage/depositKcal/deposit_token.dart';
import 'package:pock_gym/ui/mainPage/subPage/myPage/membership_info.dart';
import 'package:pock_gym/ui/mainPage/subPage/myPage/my_page.dart';
import 'package:pock_gym/ui/mainPage/subPage/notificationSetting/notification_setting.dart';
import 'package:pock_gym/ui/mainPage/subPage/purchaseHistory/purchase_history.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/buyQuest/buy_solo_quest.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/controller/main_sub_01_controller.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/controller/main_sub_02_controller.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/controller/main_sub_03_controller.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/controller/main_sub_04_controller.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/details/samsungSoloDetailPages/samsung_solo_detail_page_a.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/details/samsungSoloDetailPages/samsung_solo_detail_page_b.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/details/samsungTogetherDetailPages/together_detail_page_a.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/details/samsungTogetherDetailPages/together_detail_page_b.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/details/soloDetailPages/solo_detail_page_a.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/details/soloDetailPages/solo_detail_page_b.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/details/togetherDetailPages/together_detail_page_a.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/details/togetherDetailPages/together_detail_page_b.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/freePoint/free_point_page.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/membership/membership_page.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage02/controller/main_02_controller.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage02/sub/details/best_review_detail_page.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage02/sub/details/notice_detail_page.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage03/controller/main_03_controller.dart';
import 'package:pock_gym/ui/mainPage/subPage/terms/terms_root.dart';
import 'package:pock_gym/ui/mainPage/subPage/widthraw/widthraw_page.dart';
import 'package:pock_gym/ui/widthraw/widthrawCash/widthraw_cash.dart';
import 'package:pock_gym/ui/widthraw/widthrawPPT/widthraw_ppt.dart';
import 'package:pock_gym/utils/debug_print.dart';
import 'package:pock_gym/utils/url_launcher.dart';

tPath(var targetPath, var targetOption) async {
  SplashController sc = Get.find();

  dPrint("TargetPath :: " + targetPath.toString() + " / " + "TargetOption :: " + targetOption.toString());
  switch (targetPath) {
    case "membership":
      dPrint("membership");
      // Get.to(const MembershipPage());
      Get.to(MembershipInfoPage());
      break;

    case "coupon":
      dPrint("coupon");
      var result = await Get.to(CouponList());
      return result;

    case "togetherQuest":
      dPrint("togetherQuest");
      MainSub01Controller mainSub01Controller = Get.find();
      mainSub01Controller.currentCategoryIndex(2);
      mainSub01Controller.changeBodyIndex(2);

      MainSub03Controller mainSub03Controller = Get.find();
      mainSub03Controller.selectedCategoryIndex(int.parse(targetOption));

      // var result = await Get.to(CouponList());
      // return result;
      break;

    case "soloQuest":
      dPrint("soloQuest");
      MainSub01Controller mainSub01Controller = Get.find();
      mainSub01Controller.currentCategoryIndex(1);
      mainSub01Controller.changeBodyIndex(1);

      MainSub02Controller mainSub02Controller = Get.find();
      mainSub02Controller.selectedCategoryIndex(int.parse(targetOption));

      // var result = await Get.to(CouponList());
      // return result;
      break;

    case "samsungQuest":
      dPrint("samsungQuest");
      MainSub01Controller mainSub01Controller = Get.find();
      mainSub01Controller.currentCategoryIndex(3);
      mainSub01Controller.changeBodyIndex(3);

      MainSub04Controller mainSub04Controller = Get.find();
      mainSub04Controller.selectedCategoryIndex(int.parse(targetOption));

      // var result = await Get.to(CouponList());
      // return result;
      break;
    case "freeKcal":
      dPrint("freeKcal");
      Get.to(const FreePointPage());
      break;
    case "completedQuest":
      dPrint("completedQuest");
      MainController mainController = Get.find();
      mainController.bottomNaviCurrentIndex(2);

      Main03Controller main03controller = Get.find();
      main03controller.currentCategoryIndex(1);
      main03controller.changeBodyIndex(1);

      // Get.to(const FreePointPage());
      break;
    case "notice":
      dPrint("notice");
      MainController mainController = Get.find();
      mainController.bottomNaviCurrentIndex(1);
      Main02Controller main02controller = Get.find();
      main02controller.currentCategoryIndex(0);
      main02controller.changeBodyIndex(0);
      break;
    case "url":
      dPrint("url");
      goToWeb(targetOption);
      break;
    case "mypage":
      dPrint("mypage");
      Get.to(const MyPage());
      break;
    case "mypageCs":
      dPrint("mypageCs");
      Get.to(CustomerCenter());
      break;
    default:
  }

  // switch (targetPath) {
  //   case "onboarding":
  //     dPrint("onboarding");
  //     Get.offAll(const OnBoardingRootPage());
  //     break;
  //   case "login":
  //     dPrint("login");
  //     Get.offAll(const LoginPage());
  //     break;
  //   case "emailregister":
  //     dPrint("emailregister");
  //     Get.to(const EmailRegisterPage());
  //     break;
  //   case "mainPage":
  //     dPrint("mainPage");
  //     Get.offAll(const MainPageRoot());
  //     break;
  //   case "notificaton":
  //     dPrint("notificaton");
  //     // Get.to(const MainPageRoot());
  //     break;
  //   case "myPage":
  //     dPrint("myPage");
  //     Get.to(const MyPage());
  //     break;
  //   case "freePoint":
  //     dPrint("freePoint");
  //     Get.to(const FreePointPage());
  //     break;
  //   case "membership":
  //     dPrint("membership");
  //     Get.to(const MembershipPage());
  //     break;
  //   // case "buySoloQuest":
  //   //   dPrint("buySoloQuest");
  //   //   var result = await Get.to(const BuySoloQuest());
  //   //   return result;
  //   case "bestReview":
  //     dPrint("bestReview");
  //     var result = await Get.to(BestReviewDetailPage(data: BestReviewItemResponse.fromJson(jsonDecode(jsonEncode(targetOption)))));
  //     return result;
  //   case "noticeDetail":
  //     dPrint("noticeDetail");
  //     var result = await Get.to(NoticeDetailPage(data: BestReviewItemResponse.fromJson(jsonDecode(jsonEncode(targetOption)))));
  //     return result;
  //   case "widthrawCash":
  //     dPrint("widthrawCash");
  //     var result = await Get.to(WidthrawCash(
  //       initIndex: targetOption,
  //     ));
  //     return result;
  //   case "widthrawPPT":
  //     dPrint("widthrawPPT");
  //     var result = await Get.to(WidthrawPPT(
  //       initIndex: targetOption,
  //     ));
  //     return result;
  //   case "depositKcal":
  //     dPrint("depositKcal");
  //     var result = await Get.to(DepositKcal());
  //     return result;
  //   case "depositToken":
  //     dPrint("depositToken");
  //     var result = await Get.to(DepositTokenPage());
  //     return result;
  //   case "purchaseHistory":
  //     dPrint("purchaseHistory");
  //     var result = await Get.to(PurchaseHistory());
  //     return result;
  //   case "couponList":
  //     dPrint("couponList");
  //     var result = await Get.to(CouponList());
  //     return result;
  //   case "notificationSetting":
  //     dPrint("notificationSetting");
  //     var result = await Get.to(NotificationSettiing());
  //     return result;
  //   case "customerCenter":
  //     dPrint("customerCenter");
  //     var result = await Get.to(CustomerCenter());
  //     return result;
  //   case "faq":
  //     dPrint("faq");
  //     var result = await Get.to(FaQPage());
  //     return result;
  //   case "question":
  //     dPrint("question");
  //     var result = await Get.to(QuestionPage());
  //     return result;
  //   case "termsRoot":
  //     dPrint("termsRoot");
  //     var result = await Get.to(TermsRootPage());
  //     return result;
  //   case "widthraw":
  //     dPrint("widthraw");
  //     var result = await Get.to(WidthrawPage());
  //     return result;
  //   case "soloDetail":
  //     dPrint("soloDetail");
  //     dPrint(targetOption);

  //     var questIdx = sc.participatingList.value.indexWhere((element) => element == targetOption);
  //     if (questIdx == -1) {
  //       Get.to(SoloDetailPageBefore(
  //         idx: targetOption,
  //       ));
  //     } else {
  //       Get.to(() => SoloDetailPageAfter(
  //             idx: targetOption,
  //           ));
  //     }

  //     break;
  //   case "samsungSoloDetail":
  //     dPrint("samsungSoloDetail");
  //     dPrint(targetOption);

  //     var questIdx = sc.participatingList.value.indexWhere((element) => element == targetOption);
  //     if (questIdx == -1) {
  //       Get.to(SamsungSoloDetailPageBefore(
  //         idx: targetOption,
  //       ));
  //     } else {
  //       Get.to(() => SamsungSoloDetailPageAfter(
  //             idx: targetOption,
  //           ));
  //     }

  //     break;
  //   case "samsungTogetherDetail":
  //     dPrint("samsungTogetherDetail");
  //     dPrint(targetOption);

  //     var questIdx = sc.participatingList.value.indexWhere((element) => element == targetOption);
  //     if (questIdx == -1) {
  //       Get.to(SamsungTogetherPageBefore(
  //         idx: targetOption,
  //       ));
  //     } else {
  //       Get.to(() => SamsungTogetherDetailPageAfter(
  //             idx: targetOption,
  //           ));
  //     }

  //     break;
  //   case "togetherDetail":
  //     dPrint("togetherDetail");

  //     var questIdx = sc.participatingList.value.indexWhere((element) => element == targetOption);
  //     if (questIdx == -1) {
  //       Get.to(TogetherPageBefore(
  //         idx: targetOption,
  //       ));
  //     } else {
  //       Get.to(TogetherDetailPageAfter(
  //         idx: targetOption,
  //       ));
  //     }

  //     break;
  //   default:
  // }
}
