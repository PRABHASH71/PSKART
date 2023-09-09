import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskart/firebase_helper/firebase_Auth/firebaseAuthHelper.dart';
import 'package:pskart/provider/app_provider.dart';
import 'package:pskart/screens/auth_ui/login/welcome.dart';
import 'package:pskart/screens/bottom_navigation_bar.dart';
import 'package:pskart/screens/home/home.dart';
import 'package:pskart/screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PSKART',
          home: StreamBuilder(
            stream: FirebaseAuthHelper.instance.getAuthChange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const bottomNavigation();
              }
              return const splashScreen();
            },
          )),
    );
  }
}
