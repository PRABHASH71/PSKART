import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/firebase_helper/firebase_Auth/firebasefirestorehelper.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/provider/app_provider.dart';
import 'package:pskart/screens/bottom_navigation_bar.dart';
import 'package:pskart/screens/buySplashScreen.dart';

class CartBuyProduct extends StatefulWidget {
  final double price;
  final String address;
  final String pincode;

  const CartBuyProduct({
    required this.price,
    required this.address,
    required this.pincode,
    super.key,
  });

  @override
  State<CartBuyProduct> createState() => _CartBuyProductState();
}

class _CartBuyProductState extends State<CartBuyProduct> {
  int groupvalue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      bottomNavigationBar: SizedBox(
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
                      "\$" + "${widget.price}",
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
                          onPressed: () async {
                            bool value = await FirebaseFirestoreHelper.instance
                                .uploadOrderedProductFirebase(
                              appProvider.getBuyProductList,
                              context,
                              groupvalue == 1
                                  ? "Cash on Delivery"
                                  : "Paid Online",
                              widget.address,
                              widget.pincode,
                            );
                            if (value) {
                              Routes.instance.push(
                                  widget: cartsplashScreen(), context: context);
                            }
                          },
                          child: Text("BUY")),
                    )),
              ],
            ),
          )),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Payment"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Color.fromARGB(255, 170, 170, 170), width: 2.0)),
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: groupvalue,
                      onChanged: (value) {
                        setState(() {
                          groupvalue = value!;
                        });
                      }),
                  Icon(Icons.money),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Color.fromARGB(255, 170, 170, 170), width: 2.0)),
              child: Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: groupvalue,
                      onChanged: (value) {
                        setState(() {
                          groupvalue = value!;
                        });
                      }),
                  Icon(Icons.money),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Pay Online",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomRadio extends StatefulWidget {
  final int value;
  final int groupValue;
  final void Function(int) onChanged;
  const CustomRadio(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? Colors.white : Colors.grey[200]),
        child: Icon(
          Icons.circle,
          size: 30,
          color: selected ? Colors.deepPurple : Colors.grey[200],
        ),
      ),
    );
  }
}
