import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pock_gym/utils/toast/custom_toast.dart';

showBotToast(String message, Color color, Alignment alignment, int seconds) {
  BotToast.showCustomNotification(
      align: alignment,
      duration: Duration(seconds: seconds),
      toastBuilder: (fun) {
        return CustomBotToast(fun: fun, text: message, color: color);
      });
}

showBotToastBooster(String message, Color color, Alignment alignment, int seconds) {
  BotToast.showCustomNotification(
      align: alignment,
      duration: Duration(seconds: seconds),
      toastBuilder: (fun) {
        return CustomBotToastBooster(fun: fun, text: message, color: color);
      });
}

showBotToastBoosterError(String message, Color color, Alignment alignment, int seconds) {
  BotToast.showCustomNotification(
      align: alignment,
      duration: Duration(seconds: seconds),
      toastBuilder: (fun) {
        return CustomBotToastBoosterError(fun: fun, text: message, color: color);
      });
}
