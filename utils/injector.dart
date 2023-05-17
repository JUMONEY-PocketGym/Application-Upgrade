import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pock_gym/main.dart';
import 'package:pock_gym/utils/ads/ads_init.dart';
import 'package:pock_gym/utils/auth/kakao/kakao_auth_init.dart';
import 'package:pock_gym/utils/onesignal.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

bool crashlyticsCheck = false;

class Injector {
  Injector._();

  static Future<void> inject() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // await Firebase.initializeApp();
    // FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    cameras = await availableCameras();
    await GetStorage.init();
    await Firebase.initializeApp();
    await adsInit();
    MobileAds.instance.initialize();
    if (defaultTargetPlatform == TargetPlatform.android) {
      InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
    }

    await kakaoInit();
    await Hive.initFlutter();

    await Hive.openBox("block_list");
    timeago.setLocaleMessages('ko', timeago.KoMessages());

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    // if (crashlyticsCheck) FirebaseCrashlytics.instance.crash();

    // Get.put<ApiAuthController>(ApiAuthController());

    // await Get.putAsync<SharedPreferences>(() async => await SharedPreferences.getInstance(), permanent: true);
  }
}
