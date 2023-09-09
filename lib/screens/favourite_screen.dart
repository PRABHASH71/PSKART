import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/constants/single_widget.dart';
import 'package:pskart/constants/singlefavourite.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/provider/app_provider.dart';
import 'package:pskart/screens/home/home.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Favourite Screen",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: appProvider.getFavouriteProductList.isEmpty
            ? Center(
                child: Text(
                  "FAVOURITE LIST IS EMPTY",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: appProvider.getFavouriteProductList.length,
                itemBuilder: (ctx, index) {
                  return singleFavourite(
                      singleProduct:
                          appProvider.getFavouriteProductList[index]);
                },
              ));
  }
}
