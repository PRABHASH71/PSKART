import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/screens/auth_ui/login/welcome.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), (() {
      Routes.instance.push(widget: welcome(), context: context);
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Image.asset("assets/Pk.png")),
            Container(
              height: 100,
              width: 100,
              child: Lottie.network(
                  'https://assets10.lottiefiles.com/packages/lf20_t5zkfmnt.json'),
            )
          ],
        ),
      ),
    );
  }
}
