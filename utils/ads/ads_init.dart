import 'package:get/utils.dart';
import 'package:pock_gym/utils/debug_print.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

adsInit() {
  UnityAds.init(
    gameId: GetPlatform.isAndroid ? '5195741' : "5195740",
    testMode: false,
    onComplete: () => dPrint("UnityAds :: " + 'Initialization Complete'),
    onFailed: (error, message) => dPrint("UnityAds :: " + 'Initialization Failed: $error $message'),
  );
}
