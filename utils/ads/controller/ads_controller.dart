import 'package:get/get.dart';
import 'package:pock_gym/utils/debug_print.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class AdsController extends GetxController {
  var isLoading = false.obs;

  var loadedRewardAds = false.obs;

  loadRewardAds() {
    UnityAds.load(
      placementId: GetPlatform.isAndroid ? 'Android_reward' : 'Rewarded_iOS',
      onComplete: (placementId) {
        loadedRewardAds(true);
        dPrint("UnityAds :: " + "onComplete");
      },
      onFailed: (placementId, error, message) {
        loadedRewardAds(false);
        dPrint("UnityAds :: " + 'Load Failed $placementId: $error $message');
      },
    );
  }
}
