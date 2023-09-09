import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/screens/auth_ui/login/welcome.dart';
import 'package:pskart/screens/bottom_navigation_bar.dart';

class cancelsplashScreen extends StatefulWidget {
  const cancelsplashScreen({super.key});

  @override
  State<cancelsplashScreen> createState() => _cancelsplashScreenState();
}

class _cancelsplashScreenState extends State<cancelsplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3600), (() {
      Routes.instance.push(widget: bottomNavigation(), context: context);
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500,
              width: 500,
              child: Lottie.network(
                "https://lottie.host/99049da1-eaf5-4b92-a50d-50a902169cec/UrU8FFIAS1.json",
                frameRate: FrameRate.max,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
