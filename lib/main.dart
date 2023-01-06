import 'package:blades/services/shared_preference_service.dart';
import 'package:blades/utils/status_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'screens/pageview_video.dart';
import 'screens/selection_page.dart';
import 'utils/colors.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppHelper.setStatusbar();
  await Future.delayed(const Duration(seconds: 3))
      .then((value) => FlutterNativeSplash.remove());
  configLoading();
  runApp(MyApp(
      defaultpage: (await getlogin() == true)
          ? const PageViewVideo()
          : const SelectionPage()));
}

class MyApp extends StatelessWidget {
  final Widget defaultpage;
  const MyApp({Key? key, required this.defaultpage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rn Appz',
      theme: ThemeData(
        primarySwatch: primarySwatch,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kWhite,
        fontFamily: 'Poppins',
      ),
      home: defaultpage,
      builder: EasyLoading.init(),
    );
  }
}
