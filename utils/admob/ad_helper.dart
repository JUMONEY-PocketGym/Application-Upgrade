// import 'dart:io';
// import 'dart:math';

// class AdHelper {
//   // static String get bannerAdUnitId {
//   //   if (Platform.isAndroid) {
//   //     return 'ca-app-pub-3940256099942544/6300978111';
//   //   } else if (Platform.isIOS) {
//   //     return 'ca-app-pub-3940256099942544/2934735716';
//   //   } else {
//   //     throw UnsupportedError('Unsupported platform');
//   //   }
//   // }

//   static String get interstitialAdUnitId {
//     if (Platform.isAndroid) {
//       return getInterstitialAdUnitId();
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-3940256099942544/4411468910";
//     } else {
//       throw UnsupportedError("Unsupported platform");
//     }
//   }

//   static String get openAdUnitId {
//     if (Platform.isAndroid) {
//       return getOpenAdUnitId();
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-3940256099942544/5662855259";
//     } else {
//       throw UnsupportedError("Unsupported platform");
//     }
//   }

//   static String get rewardedAdUnitId {
//     if (Platform.isAndroid) {
//       return getRewardedAdUnitId();
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-3940256099942544/1712485313";
//     } else {
//       throw UnsupportedError("Unsupported platform");
//     }
//   }
// }

// List<String> admobInterstitialAdKey = [
//   "ca-app-pub-1931895890273679/7761661675",
//   "ca-app-pub-7369960356001679/5208215172",
//   "ca-app-pub-7369960356001679/5208215172",
//   // "ca-app-pub-2346481696974391/2109061509",
// ];

// List<String> admobOpenAdKey = [
//   "ca-app-pub-1931895890273679/3352208028",
//   "ca-app-pub-7369960356001679/7580880033",
//   "ca-app-pub-7369960356001679/7580880033",
//   // "ca-app-pub-2346481696974391/8482898162",
// ];

// List<String> admobRewardedAdKey = [
//   "ca-app-pub-1931895890273679/4665289694",
//   "ca-app-pub-7369960356001679/5477460875",
//   "ca-app-pub-7369960356001679/5477460875",
//   // "ca-app-pub-2346481696974391/3264578110",
// ];

// getInterstitialAdUnitId() {
//   String result = (admobInterstitialAdKey.toList()..shuffle()).first;
//   return result;
// }

// getOpenAdUnitId() {
//   String result = (admobOpenAdKey.toList()..shuffle()).first;
//   return result;
// }

// getRewardedAdUnitId() {
//   String result = (admobRewardedAdKey.toList()..shuffle()).first;
//   return result;
// }
