import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pskart/constants/constants.dart';
import 'package:pskart/firebase_helper/firebase_Auth/firebase_storage.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/models/userModel.dart';
import 'package:pskart/firebase_helper/firebase_Auth/firebasefirestorehelper.dart';

class AppProvider with ChangeNotifier {
  //cart List
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];
  Usermodel? _usermodel;
  Usermodel get getUserInformation => _usermodel!;

  void addcartProduct(ProductModel productmodel) {
    _cartProductList.add(productmodel);
    notifyListeners();
  }

  void removecartProduct(ProductModel productmodel) {
    _cartProductList.remove(productmodel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  // Favourite //
  final List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productmodel) {
    _favouriteProductList.add(productmodel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productmodel) {
    _favouriteProductList.remove(productmodel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  void getUserInfoFirebase() async {
    _usermodel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      BuildContext context, usermodel, File? file) async {
    showLoaderDialogue(context);
    if (file == null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(usermodel.id)
          .set(usermodel.toJson());
    } else {
      String imageurl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _usermodel = usermodel.copyWith(image: imageurl);
      print("my url is this" + imageurl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_usermodel!.id)
          .set(_usermodel!.toJson());
      notifyListeners();
      Navigator.of(context).pop();
    }
  }

  double totalPrice() {
    double totalPrice = 0;
    for (var elements in _cartProductList) {
      totalPrice += int.parse(elements.price) * elements.qty!;
    }
    return totalPrice;
  }

  void UpdateQuantity(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  void addBuyProduct(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCart() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;
}
