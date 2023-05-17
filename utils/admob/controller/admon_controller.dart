// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:pock_gym/ui/intro/splash/controller/splash_controller.dart';
// import 'package:pock_gym/utils/debug_print.dart';

// class AdmobController extends GetxController with WidgetsBindingObserver {
//   var isLoading = false.obs;

//   RewardedAd? rewardedAd;

//   SplashController sc = Get.find();

//   var isAdmobLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onClose() {}

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {}

//   void loadRewardedAd() {
//     RewardedAd.load(
//       adUnitId: "ca-app-pub-5589265170068878/3754771939",
//       // adUnitId: "ca-app-pub-3940256099942544/5224354917",
//       request: AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (ad) {
//           ad.fullScreenContentCallback = FullScreenContentCallback(
//             onAdDismissedFullScreenContent: (ad) {
//               ad.dispose();
//               rewardedAd = null;

//               loadRewardedAd();
//             },
//           );

//           rewardedAd = ad;
//         },
//         onAdFailedToLoad: (err) {
//           dPrint('Failed to load a rewarded ad: ${err.message}');
//         },
//       ),
//     );
//   }
// }
