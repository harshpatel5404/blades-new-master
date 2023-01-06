import 'package:flutter/services.dart';
import 'colors.dart';
import 'package:flutter/material.dart';

class AppHelper {
  static void setStatusbar() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      // statusBarIconBrightness: Brightness.dark,

      // systemNavigationBarColor: kWhite,
      // systemNavigationBarIconBrightness: Brightness.dark,
    ));
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  }
}
