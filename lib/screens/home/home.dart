import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pskart/constants/categorie.dart';
import 'package:pskart/constants/homeAppBar.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/firebase_helper/firebase_Auth/firebasefirestorehelper.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/provider/app_provider.dart';
import 'package:pskart/screens/auth_ui/login/welcome.dart';
import 'package:pskart/screens/cart.dart';
import 'package:pskart/screens/product._details.dart';
import 'package:pskart/screens/splashscreen.dart';
import 'package:badges/badges.dart' as badges;

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
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

  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProduct(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60))),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              )),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
          title: const Text(
            " Pskart",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          actions: [
            appProvider.getCartProductList.length == 0
                ? IconButton(
                    onPressed: () {
                      Routes.instance
                          .push(widget: cartPage(), context: context);
                    },
                    icon: Icon(Icons.shopping_cart))
                : badges.Badge(
                    position: badges.BadgePosition.custom(
                      top: 2,
                      end: 10,
                    ),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: Colors.red,
                    ),
                    badgeContent: Text(
                      "${appProvider.getCartProductList.length}",
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Routes.instance
                            .push(widget: cartPage(), context: context);
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                      ),
                    ),
                  )
          ]),
      body: Container(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: Color(0xFFEDECF2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  )),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          height: 50,
                          width: 250,
                          child: TextFormField(
                            controller: search,
                            onChanged: (String value) {
                              searchProduct(value);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search here...",
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.search,
                          size: 27,
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CategoriesWidget(),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Text(
                      "Best Selling",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  search.text.isNotEmpty && searchList.isEmpty
                      ? Center(child: Text("No Product Found"))
                      : searchList.isNotEmpty
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.78,
                                    ),
                                    itemCount: searchList.length,
                                    itemBuilder: (ctx, index) {
                                      ProductModel singleProduct =
                                          searchList[index];
                                      return InkWell(
                                        onTap: () {
                                          Routes.instance.push(
                                              widget: ProductsDetails(
                                                  singleProduct: singleProduct),
                                              context: context);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 15),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Text(
                                                        "-50%",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Routes.instance.push(
                                                        widget: ProductsDetails(
                                                            singleProduct:
                                                                singleProduct),
                                                        context: context);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.all(5),
                                                    child: Image.network(
                                                      singleProduct.image,
                                                      height: 100,
                                                      width: 110,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 3),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    singleProduct.name,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "\₹" +
                                                            singleProduct.price,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255, 0, 39, 74),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .shopping_cart_checkout,
                                                        size: 23,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.78,
                                    ),
                                    itemCount: productModelList.length,
                                    itemBuilder: (ctx, index) {
                                      ProductModel singleProduct =
                                          productModelList[index];
                                      return InkWell(
                                        onTap: () {
                                          Routes.instance.push(
                                              widget: ProductsDetails(
                                                  singleProduct: singleProduct),
                                              context: context);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 15),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Text(
                                                        "-50%",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Routes.instance.push(
                                                        widget: ProductsDetails(
                                                            singleProduct:
                                                                singleProduct),
                                                        context: context);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.all(5),
                                                    child: Image.network(
                                                      singleProduct.image,
                                                      height: 100,
                                                      width: 110,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 3),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    singleProduct.name,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "\₹" +
                                                            singleProduct.price,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255, 0, 39, 74),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .shopping_cart_checkout,
                                                        size: 23,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )

                  /// gridview
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          width: 100,
          height: 100,
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.blue])),
                child: Container(
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(60.0)),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/Pk.png"),
                          radius: 50,
                        ),
                        shadowColor: Color.fromARGB(255, 240, 237, 237),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "PSKART",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.blue])),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    user!.email!,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.blue])),
                child: ListTile(
                  leading: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  title: Text(
                    "MENU",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.blue])),
                child: ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  title: Text(
                    "CART",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.blue])),
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Routes.instance
                        .push(widget: splashScreen(), context: context);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.blue])),
                child: ListTile(
                  leading: Icon(
                    Icons.help,
                    color: Color.fromARGB(170, 255, 255, 255),
                  ),
                  title: Text(
                    "HELP",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
