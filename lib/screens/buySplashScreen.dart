import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/screens/auth_ui/login/welcome.dart';
import 'package:pskart/screens/bottom_navigation_bar.dart';

class cartsplashScreen extends StatefulWidget {
  const cartsplashScreen({super.key});

  @override
  State<cartsplashScreen> createState() => _cartsplashScreenState();
}

class _cartsplashScreenState extends State<cartsplashScreen> {
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
                "https://lottie.host/2f27f2eb-80a0-4de7-9474-56f7c42660a8/6g9YEOnTPP.json",
                frameRate: FrameRate.max,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
