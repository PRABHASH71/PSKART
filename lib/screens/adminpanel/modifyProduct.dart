import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pskart/constants/constants.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/screens/adminpanel/AddProduct.dart';

class modifyProducts extends StatefulWidget {
  final ProductModel singleproduct;

  const modifyProducts({required this.singleproduct, super.key});

  @override
  State<modifyProducts> createState() => _modifyProductsState();
}

class _modifyProductsState extends State<modifyProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Modify Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: 300,
                child: Image.network(widget.singleproduct.image),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name : " + widget.singleproduct.name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Price : " + widget.singleproduct.price,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Description : " + widget.singleproduct.description,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Status : " + widget.singleproduct.status,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      width: 150,
                      child: Center(
                          child: Text("Update",
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      FirebaseStorage.instance
                          .refFromURL(widget.singleproduct.image)
                          .delete();
                      showMessage("Product deleted successfully");
                      await FirebaseFirestore.instance
                          .collection('categories')
                          .doc(widget.singleproduct.id)
                          .delete();
                      Routes.instance
                          .push(widget: AddProduct(), context: context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      width: 150,
                      child: Center(
                          child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
