import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pskart/screens/ProfilePage.dart';
import 'package:pskart/screens/cart.dart';
import 'package:pskart/screens/favourite_screen.dart';
import 'package:pskart/screens/home/home.dart';
import 'package:pskart/screens/order_screen.dart';

class bottomNavigation extends StatefulWidget {
  const bottomNavigation({super.key});

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {
  final items = [
    Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.shopping_cart,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.favorite,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.shopping_bag,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.menu,
      size: 30,
      color: Colors.white,
    ),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        height: 60,
        backgroundColor: Colors.transparent,
        color: Colors.blue,
      ),
      body: getselectedWidget(index: index),
    );
  }

  Widget getselectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = homePage();
        break;
      case 1:
        widget = cartPage();
        break;
      case 2:
        widget = FavouritePage();
        break;
      case 3:
        widget = Order_Screen();
        break;
      case 4:
        widget = ProfilePage();
        break;
      default:
        widget = homePage();
        break;
    }
    return widget;
  }
}
