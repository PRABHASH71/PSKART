import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> strArr = [
      "Categories",
      'Watches',
      'Coats',
      "Shirts",
      "Shoes",
      "Sneakers"
    ];
    Widget convert(int key) {
      String st = strArr[key];
      return Text(
        st,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 1; i < 6; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/$i.png",
                    width: 40,
                    height: 31,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  convert(i),
                ],
              ),
            )
        ],
      ),
    );
  }
}
