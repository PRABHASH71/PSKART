import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pskart/constants/constants.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/firebase_helper/firebase_Auth/firebase_storage.dart';
import 'package:pskart/firebase_helper/firebase_Auth/firebasefirestorehelper.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/models/testModel.dart';
import 'package:pskart/screens/adminpanel/modifyProduct.dart';
import 'package:pskart/screens/auth_ui/login/welcome.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? image1;
  String? image2;
  void takepicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image1 = File(value.path);
      });

      String uniquename = DateTime.now().microsecondsSinceEpoch.toString();
      Reference referenceroot = FirebaseStorage.instance.ref();
      Reference referencedirImage = referenceroot.child('images');

      Reference refereImageUpload = referencedirImage.child(uniquename);
      try {
        await refereImageUpload.putFile(File(value.path));
        image2 = await refereImageUpload.getDownloadURL();
        showMessage("ImageUploadedSuccessfully");
      } catch (error) {
        showMessage(error.toString());
      }
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();

  TextEditingController description = TextEditingController();

  bool isLoading = false;

  List<ProductModel> productModelList = [];
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance.getbestProducts();

    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        takepicture();
                      },
                      child: image1 == null
                          ? CircleAvatar(
                              radius: 30, child: Icon(Icons.camera_alt))
                          : CircleAvatar(
                              backgroundImage: FileImage(image1!, scale: 1),
                              radius: 100,
                            )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: "Name of Product",
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: price,
                    decoration: InputDecoration(
                      hintText: "Price of Product",
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    maxLines: 2,
                    controller: description,
                    decoration: InputDecoration(
                      hintText: "Description of Product",
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      Timestamp newtime = Timestamp.now();
                      if (image2 == null ||
                          name.text.toString().isEmpty ||
                          description.text.toString().isEmpty ||
                          price.text.toString().isEmpty) {
                        Fluttertoast.showToast(msg: "Field are null");
                      } else {
                        if (true) {
                          bool value = await FirebaseFirestoreHelper.instance
                              .uploadtryProductFirebase(name.text, price.text,
                                  description.text, image2!);
                          if (value) {
                            Routes.instance
                                .push(widget: welcome(), context: context);
                          }
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      width: 150,
                      child: Center(
                          child: Text(
                        "ADD PRODUCT",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 30,
              ),
              Text(
                "View Products",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              (isLoading == true)
                  ? CircularProgressIndicator()
                  : SizedBox(
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.78,
                        ),
                        itemCount: productModelList.length,
                        itemBuilder: (context, index) {
                          ProductModel singleProduct = productModelList[index];
                          return InkWell(
                            onTap: () {
                              Routes.instance.push(
                                  widget: modifyProducts(
                                      singleproduct: singleProduct),
                                  context: context);
                            },
                            child: Container(
                                height: 400,
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 15),
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        singleProduct.image.toString(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(singleProduct.name),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Price : " + singleProduct.price),
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
