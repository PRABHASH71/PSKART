import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/provider/app_provider.dart';
import 'package:pskart/screens/address.dart';
import 'package:pskart/screens/buy_page.dart';
import 'package:pskart/screens/cartAddress.dart';
import 'package:pskart/screens/cart_buy_page.dart';

class singleselectAddress extends StatefulWidget {
  final double price;

  final bool cart;
  final ProductModel productModel;
  const singleselectAddress(
      {required this.price,
      required this.productModel,
      required this.cart,
      super.key});

  @override
  State<singleselectAddress> createState() => _singleselectAddressState();
}

class _singleselectAddressState extends State<singleselectAddress> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    appProvider.getUserInfoFirebase();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Select Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: 200,
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(30),
                        child: Image.network(
                          appProvider.getUserInformation.image.toString(),
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Name : " +
                        appProvider.getUserInformation.name.toString()),
                    SizedBox(height: 10),
                    Text("Address : " +
                        appProvider.getUserInformation.address.toString()),
                    SizedBox(height: 10),
                    Text("Pincode : " +
                        appProvider.getUserInformation.pincode.toString()),
                    SizedBox(height: 10),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 225, 225, 225),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Routes.instance.push(
                          widget: BuyProduct(
                            Address: appProvider.getUserInformation.address
                                .toString(),
                            pincode: appProvider.getUserInformation.pincode
                                .toString(),
                            price: widget.price,
                            singleProduct: widget.productModel,
                          ),
                          context: context);
                    },
                    child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text(
                          "BUY",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Routes.instance.push(
                          widget: AddressSection(
                              cart: false,
                              productModel: widget.productModel,
                              price: widget.price),
                          context: context);
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        "Change Address",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
