import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pock_gym/ui/intro/splash/controller/splash_controller.dart';
import 'package:pock_gym/utils/debug_print.dart';
import 'package:pock_gym/utils/routers/t_path.dart';
import 'package:pock_gym/utils/routers/target_path.dart';
import 'package:pock_gym/utils/secure_storage.dart';

getPermissionInfo() async {
  var result = await OneSignal.shared.promptUserForPushNotificationPermission();
  return result;
}

onsignalInit() async {
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("eaed1350-981e-4211-9478-a46a6f45552e");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) async {
    dPrint("CHECK ::::: Accepted permission: $accepted");

    var result = await getPermissionInfo();
    var getTag = await OneSignal.shared.getTags();

    dPrint("CHECK ::::: promptUserForPushNotificationPermission: " + result.toString());
    dPrint("CHECK ::::: getTag: " + getTag['push01'].toString());

    SplashController sc = Get.find();
    sc.notificationPermission(accepted);

    if (!accepted) {
      sc.push01(false);
      OneSignal.shared.sendTag("push01", false);
    } else {
      sc.push01(getTag['push01'] == "true" ? true : false);
    }

    // sc.push01(accepted);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await storage.write(key: "push01", value: accepted.toString());
    // });
  });

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) async {
    // Will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
    dPrint("CHECK ::::: setPermissionObserver :: " + changes.to.hasPrompted.toString());
    SplashController sc = Get.find();
    sc.notificationPermission(changes.to.hasPrompted);
    sc.push01(changes.to.hasPrompted);

    OneSignal.shared.sendTag("push01", changes.to.hasPrompted);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await storage.write(key: "push01", value: changes.to.hasPrompted.toString());
    // });
  });

  OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // Will be called whenever the subscription changes
    // (ie. user gets registered with OneSignal and gets a user ID)

    dPrint("CHECK ::::: setSubscriptionObserver" + changes.to.isSubscribed.toString());
  });

  OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
    // Will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
  });
}

onesignalHandler() async {
  SplashController sc = Get.find();

  final id = await storage.read(key: 'uid');

  final initPush = await storage.read(key: 'initPush');
  if (initPush == null) {
    OneSignal.shared.sendTag("push01", "true");
    OneSignal.shared.sendTag("push02", "true");
    OneSignal.shared.sendTag("push03", "true");
    OneSignal.shared.sendTag("push04", "true");
    OneSignal.shared.sendTag("push05", "true");
    OneSignal.shared.sendTag("push06", "true");
    await storage.write(key: "initPush", value: "done");
  }

  OneSignal.shared.sendTag("uid", id);

  OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);

    dPrint("onesignal additionalData :: " + event.toString());

    var additionalData = event.notification.additionalData;

    if (additionalData != null) {
      var additionalDataJson = jsonDecode(jsonEncode(additionalData));

      dPrint(jsonEncode(additionalDataJson));

      if (additionalDataJson['targetPath'].toString() != null) {
        dPrint("TargetPath :: " + additionalDataJson['targetPath'].toString());

        // targetPath 실행 ( 앱이 활성화 중일 경우에만 )
        try {
          tPath(additionalDataJson['targetPath'].toString(), additionalDataJson['targetOption']);
        } catch (e) {
          tPath(additionalDataJson['targetPath'].toString(), null);
        }
      }
      // if (additionalDataJson['targetOption'].toString() != null) {
      //   dPrint(
      //       "TargetOption :: " + additionalDataJson['targetOption'].toString());
      // }
    }
  });

  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // Will be called whenever a notification is opened/button pressed.

    var additionalData = result.notification.additionalData;
    if (additionalData != null) {
      var additionalDataJson = jsonDecode(jsonEncode(additionalData));

      dPrint(jsonEncode(additionalDataJson));

      if (additionalDataJson['targetPath'].toString() != null) {
        dPrint("TargetPath :: " + additionalDataJson['targetPath'].toString());

        // targetPath 실행 ( 앱이 활성화 중일 경우에만 )
        try {
          tPath(additionalDataJson['targetPath'].toString(), additionalDataJson['targetOption']);
        } catch (e) {
          tPath(additionalDataJson['targetPath'].toString(), null);
        }
      }
    }
  });
}
