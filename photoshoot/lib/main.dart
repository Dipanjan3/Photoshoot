import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photoshoot/activity/Splash.dart';

import 'activity/Home.dart';

void main() {
  /*SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.black, // status bar color
  ));*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      /*theme: ThemeData(
        primarySwatch: Colors.blue,
      ),*/
      home: SplashScreen(),
    );
  }
}

/*
  fonts:
    - family: SF_Pro_400
      fonts:
        - asset: assets/fonts/sf_pro_display_regular.otf
          weight: 400
    - family: SF_Pro_600
      fonts:
        - asset: assets/fonts/sf_pro_display_regular.otf
          weight: 600
    - family: SF_Pro_700
      fonts:
        - asset: assets/fonts/sf_pro_display_regular.otf
          weight: 700
    - family: SF_Pro_800
      fonts:
        - asset: assets/fonts/sf_pro_display_regular.otf
          weight: 800
    - family: SF_Pro_900
      fonts:
        - asset: assets/fonts/sf_pro_display_regular.otf
          weight: 900
 */
