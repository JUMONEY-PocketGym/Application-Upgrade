import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget systemOverlay(bool dark, Widget child) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          // for Android
          statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
          // for iOS
          statusBarBrightness: dark ? Brightness.dark : Brightness.light),
      child: child);
}
