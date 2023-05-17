import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

kakaoInit() {
  // KakaoSdk.jsKey = "886b5360945dd724550e9a79a85d1339";
  // KakaoSdk.nativeKey = "10d50e404d09e7755f9ce2836d574e48";
  // KakaoContext.clientId = "10d50e404d09e7755f9ce2836d574e48";

  KakaoSdk.init(nativeAppKey: "10d50e404d09e7755f9ce2836d574e48");

  // KakaoContext.javascriptClientId = "886b5360945dd724550e9a79a85d1339";
}
