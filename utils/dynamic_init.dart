import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:pock_gym/ui/intro/splash/controller/splash_controller.dart';
import 'package:pock_gym/utils/debug_print.dart';

dynamicLinkInit() async {
  SplashController sc = Get.find();

  await FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    // Navigator.pushNamed(context, dynamicLinkData.link.path);
    final Uri deepLink = dynamicLinkData.link;

    if (deepLink != null) {
      var inviteUid = deepLink.queryParameters['inviteUid'];

      sc.inviteUid.value = inviteUid!;
      dPrint("dynamicLink inviteUid :: " + sc.inviteUid.value.toString());
    }
  });

  final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
  final Uri? deepLink = data?.link;

  if (deepLink != null) {
    var inviteUid = deepLink.queryParameters['inviteUid'];

    sc.inviteUid.value = inviteUid!;
  }
}
