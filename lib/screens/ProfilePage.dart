import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskart/constants/constants.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/firebase_helper/firebase_Auth/firebaseAuthHelper.dart';
import 'package:pskart/provider/app_provider.dart';
import 'package:pskart/screens/buySplashScreen.dart';
import 'package:pskart/screens/edit_profile.dart';
import 'package:pskart/screens/favourite_screen.dart';
import 'package:pskart/screens/order_screen.dart';
import 'package:pskart/screens/splashscreen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    Image img = Image.asset("1.png");
    if (appProvider.getUserInformation.image != null) {
      img = Image.network(appProvider.getUserInformation.image!);
    }
    appProvider.getUserInfoFirebase();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Account"),
        ),
        body: Column(
          children: [
            Container(
                height: 250,
                width: double.infinity,
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(110),
                      bottomRight: Radius.circular(110),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      appProvider.getUserInformation.image == null
                          ? Center(
                              child: Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.white,
                              ),
                            )
                          : Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: img.image,
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        appProvider.getUserInformation.name!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Routes.instance
                              .push(widget: Edit_Profile(), context: context);
                        },
                        color: Colors.green,
                        child: Text("EDIT PROFILE"),
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Routes.instance
                              .push(widget: Order_Screen(), context: context);
                        },
                        leading: Icon(Icons.shopping_bag_outlined),
                        title: Text("Your Orders"),
                      ),
                      ListTile(
                        onTap: () {
                          Routes.instance
                              .push(widget: FavouritePage(), context: context);
                        },
                        leading: Icon(Icons.favorite_outline),
                        title: Text("Your Wishlist"),
                      ),
                      ListTile(
                        onTap: () {
                        
                        },
                        leading: Icon(Icons.info_outline),
                        title: Text("About Us"),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.support_agent),
                        title: Text("Help Center"),
                      ),
                      ListTile(
                        onTap: () {
                          FirebaseAuthHelper.instance.signout();
                          Routes.instance
                              .push(widget: splashScreen(), context: context);
                        },
                        leading: Icon(Icons.exit_to_app),
                        title: Text("Log out"),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Version  1.0.0",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 61, 61, 61),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
