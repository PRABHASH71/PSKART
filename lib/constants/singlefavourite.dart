import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskart/constants/constants.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/provider/app_provider.dart';

class singleFavourite extends StatefulWidget {
  final ProductModel singleProduct;

  const singleFavourite({
    super.key,
    required this.singleProduct,
  });

  @override
  State<singleFavourite> createState() => _singleFavouriteState();
}

class _singleFavouriteState extends State<singleFavourite> {
  @override
  Widget build(BuildContext context) {
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
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    AppProvider appProvider =
                                        Provider.of<AppProvider>(context,
                                            listen: false);
                                    appProvider.removeFavouriteProduct(
                                        widget.singleProduct);
                                    showMessage("REMOVED FROM WISHLIST");
                                  },
                                  child: Text(
                                    "Remove from Wishlist",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
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
                          "\₹" + "${widget.singleProduct.price.toString()}",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
