import 'dart:developer';

import 'package:flutter/foundation.dart';

dPrint(var v) {
  if (kDebugMode) {
    log("################### " + v.toString());
  }
}
//  void debugPrint2(var s1) {
//         String s = s1.toString();
//         debugPrint(" =======> " + s, wrapWidth: 1024);
//       }