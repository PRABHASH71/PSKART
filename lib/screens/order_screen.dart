import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pskart/constants/constants.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/firebase_helper/firebase_Auth/firebasefirestorehelper.dart';
import 'package:pskart/models/orderModel.dart';
import 'package:pskart/screens/cancelsplashscreen.dart';

class Order_Screen extends StatelessWidget {
  const Order_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Your Orders"),
      ),
      body: FutureBuilder(
          future: FirebaseFirestoreHelper.instance.getUserOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(child: Text("No Orders"));
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                padding: EdgeInsets.all(12.0),
                itemBuilder: (context, index) {
                  OrderModel orderModel = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ExpansionTile(
                      collapsedShape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: const Color.fromARGB(255, 154, 154, 154),
                              width: 2.3)),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: const Color.fromARGB(255, 154, 154, 154),
                              width: 2.3)),
                      title: Row(children: [
                        Expanded(
                          child: Container(
                            child: orderModel.products.length > 1
                                ? Image.asset("assets/Pk.png")
                                : Image.network(
                                    orderModel.products[0].image,
                                  ),
                            height: 130,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 160,
                            color: Color.fromARGB(255, 240, 240, 240),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          orderModel.products.length > 1
                                              ? Text(
                                                  "Multiple Products",
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : Text(
                                                  orderModel.products[0].name,
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 13,
                                          ),
                                          Text(
                                            "Total Price : \$${orderModel.totalPrice}",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 13,
                                          ),
                                          Text(
                                            "Products : ${orderModel.products.length}",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 13,
                                          ),
                                          Text(
                                            "Payment : ${orderModel.payment}",
                                            style: TextStyle(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              deleteit(
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  orderModel.id);

                                              Routes.instance.push(
                                                  widget: cancelsplashScreen(),
                                                  context: context);
                                            },
                                            child: Container(
                                                height: 30,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Cancel Order",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                      children: orderModel.products.length > 1
                          ? [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: orderModel.products
                                        .map((singleproduct) {
                                      return Column(
                                        children: [
                                          Row(children: [
                                            Expanded(
                                              child: Container(
                                                child: Image.network(
                                                  singleproduct.image,
                                                ),
                                                height: 80,
                                                width: 80,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                height: 140,
                                                color: Color.fromARGB(
                                                    255, 240, 240, 240),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Name : ${singleproduct.name}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 13,
                                                              ),
                                                              Text(
                                                                "Price : \$${singleproduct.price}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 13,
                                                              ),
                                                              Text(
                                                                "Quantity : ${singleproduct.qty}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 1.0,
                                    ),
                                    child: Text(
                                      "Address : ${orderModel.Address}",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text(
                                      "Pincode : ${orderModel.Pincode}",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text(
                                      "Status : ${orderModel.status}",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text(
                                      "Total : \$${orderModel.totalPrice}",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              )
                            ]
                          : [
                              ListTile(
                                title: Text("Address : ${orderModel.Address}"),
                              ),
                              ListTile(
                                title: Text("Pincode : ${orderModel.Pincode}"),
                              ),
                              ListTile(
                                title: Text(
                                    "Total Price : \$${orderModel.totalPrice}"),
                              ),
                              ListTile(
                                title: Text("Status : ${orderModel.status}"),
                              )
                            ],
                    ),
                  );
                });
          }),
    );
  }

  void deleteit(String uid, String oid) async {
    showMessage("Order is Canceled");
    FirebaseFirestore.instance
        .collection("usersOrders/" + uid + "/orders")
        .doc(oid)
        .delete();
  }
}
