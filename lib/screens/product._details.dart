import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pskart/constants/constants.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/provider/app_provider.dart';
import 'package:pskart/screens/address.dart';
import 'package:pskart/screens/buy_page.dart';
import 'package:pskart/screens/cart.dart';
import 'package:pskart/screens/favourite_screen.dart';
import 'package:badges/badges.dart' as badges;

class ProductsDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductsDetails({super.key, required this.singleProduct});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    int x = appProvider.getCartProductList.length;
    return Scaffold(
      appBar: AppBar(
        actions: [
          x == 0
              ? IconButton(
                  onPressed: () {
                    Routes.instance.push(widget: cartPage(), context: context);
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
                    "$x",
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.singleProduct.image,
              height: 300,
              width: 1000,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.singleProduct.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFav =
                            !widget.singleProduct.isFav;
                      });
                      if (widget.singleProduct.isFav) {
                        appProvider.addFavouriteProduct(widget.singleProduct);
                      } else {
                        appProvider
                            .removeFavouriteProduct(widget.singleProduct);
                      }
                    },
                    icon: Icon(
                      appProvider.getFavouriteProductList
                              .contains(widget.singleProduct)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
              child: Text(
                "\$" + widget.singleProduct.price,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.singleProduct.description,
              style: TextStyle(
                fontSize: 14,
                color: const Color.fromARGB(255, 41, 41, 41),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (qty > 1) {
                        qty--;
                      }
                    });
                  },
                  child: CircleAvatar(
                    radius: 17,
                    child: Icon(
                      Icons.remove,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  qty.toString(),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      qty++;
                    });
                  },
                  child: CircleAvatar(
                    radius: 17,
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      appProvider.addcartProduct(productModel);
                      showMessage("ADDED TO CART");
                    },
                    child: Text("ADD TO CART")),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 35,
                  width: 130,
                  child: ElevatedButton(
                      onPressed: () {
                        ProductModel productModel =
                            widget.singleProduct.copyWith(qty: qty);
                        Routes.instance.push(
                            widget: AddressSection(
                                cart: false,
                                productModel: productModel,
                                price:
                                    double.parse(widget.singleProduct.price)),
                            context: context);
                      },
                      child: Text("BUY")),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
