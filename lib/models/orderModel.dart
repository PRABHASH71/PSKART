import 'dart:convert';

import 'package:pskart/models/product_model.dart';

class OrderModel {
  String? Address;
  String? payment;
  String? Pincode;
  List<ProductModel> products;
  String id;
  String? status;
  double? totalPrice;
  OrderModel(
      {required this.id,
      required this.Address,
      required this.Pincode,
      required this.totalPrice,
      required this.payment,
      required this.products,
      required this.status});
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json['products'];
    return OrderModel(
      id: json['id'],
      Address: json['Address'],
      Pincode: json['Pincode'],
      totalPrice: json['totalPrice'],
      payment: json['payment'],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Address': Address,
      'Pincode': Pincode,
      'totalPrice': totalPrice,
      'payment': payment,
      'products': products,
      'status': status,
    };
  }
}
