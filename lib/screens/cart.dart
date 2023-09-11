import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/constants/single_widget.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/provider/app_provider.dart';
import 'package:pskart/screens/address.dart';
import 'package:pskart/screens/buy_page.dart';
import 'package:pskart/screens/cartAddress.dart';
import 'package:pskart/screens/cart_buy_page.dart';
import 'package:pskart/screens/home/home.dart';

class cartPage extends StatefulWidget {
  const cartPage({super.key});

  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  double x = 0.0;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
        bottomNavigationBar: appProvider.getCartProductList.isEmpty
            ? Container(
                height: 150,
              )
            : Container(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\₹${appProvider.totalPrice().toString()}",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 45,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    x = appProvider.totalPrice();
                                  });
                                  appProvider.clearBuyProduct();

                                  appProvider.addBuyProductCart();

                                  appProvider.clearCart();
                                  Routes.instance.push(
                                      widget: CartAddressSection(
                                        price: x,
                                      ),
                                      context: context);
                                },
                                child: Text("Buy")),
                          )),
                    ],
                  ),
                )),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            "Cart Screen",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: appProvider.getCartProductList.isEmpty
            ? Center(
                child: Text(
                  "CART IS EMPTY",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: appProvider.getCartProductList.length,
                itemBuilder: (ctx, index) {
                  return SingleCartItem(
                      singleProduct: appProvider.getCartProductList[index]);
                },
              ));
  }
}
