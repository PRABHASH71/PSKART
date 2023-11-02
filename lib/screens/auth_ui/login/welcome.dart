import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pskart/constants/asset_images.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/screens/Admin.dart';
import 'package:pskart/screens/auth_ui/login/login.dart';
import 'package:pskart/screens/auth_ui/register/register.dart';
import 'package:pskart/screens/adminpanel/AddProduct.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Image.asset(
                    AssetsImages.instance.welcome,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.facebook,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        AssetsImages.instance.glogo,
                        scale: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                      height: 45,
                      width: 330,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            Routes.instance
                                .push(widget: Login(), context: context);
                          },
                          child: Text("Users"))),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                      height: 45,
                      width: 330,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            Routes.instance
                                .push(widget: AddProduct(), context: context);
                          },
                          child: Text("Admin"))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
