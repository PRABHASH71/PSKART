import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskart/constants/constants.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/provider/app_provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({
    super.key,
    required this.singleProduct,
  });

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;
  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          6,
        ),
        border: Border.all(
            color: const Color.fromARGB(255, 187, 187, 187), width: 3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Image.network(
                widget.singleProduct.image,
              ),
              height: 140,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 140,
              color: Color.fromARGB(255, 240, 240, 240),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.singleProduct.name,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (qty > 1) {
                                        qty--;
                                      }
                                      appProvider.UpdateQuantity(
                                          widget.singleProduct, qty);
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 13,
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
                                    appProvider.UpdateQuantity(
                                        widget.singleProduct, qty);
                                  },
                                  child: CircleAvatar(
                                    radius: 13,
                                    child: Icon(
                                      Icons.add,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (!appProvider.getFavouriteProductList
                                        .contains(widget.singleProduct)) {
                                      appProvider.addFavouriteProduct(
                                          widget.singleProduct);
                                      showMessage("ADDED TO WISHLIST");
                                    } else {
                                      appProvider.removeFavouriteProduct(
                                          widget.singleProduct);
                                      showMessage("REMOVED FROM WISHLIST");
                                    }
                                  },
                                  child: Text(
                                    appProvider.getFavouriteProductList
                                            .contains(widget.singleProduct)
                                        ? "Remove From Wishlist"
                                        : "Add to WishLList",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "\$" + "${widget.singleProduct.price.toString()}",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          appProvider.removecartProduct(widget.singleProduct);
                          showMessage("REMOVED FROM CART");
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          maxRadius: 13,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 17,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
