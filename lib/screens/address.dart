import 'package:flutter/material.dart';
import 'package:pskart/constants/routes.dart';
import 'package:pskart/models/product_model.dart';
import 'package:pskart/screens/buy_page.dart';

class AddressSection extends StatefulWidget {
  final double price;

  final bool cart;
  final ProductModel productModel;
  const AddressSection(
      {required this.price,
      required this.productModel,
      required this.cart,
      super.key});

  @override
  State<AddressSection> createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  void _submit(String address, String pincode) {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Routes.instance.push(
        widget: BuyProduct(
          Address: address,
          pincode: pincode,
          price: widget.price,
          singleProduct: widget.productModel,
        ),
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Fill Address"),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'FirstName',
                      hintText: 'FirstName',
                      //icon: Icon(Icons.person),
                      isDense: true,
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Required Field';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'LastName',
                      hintText: 'LastName',
                      //icon: Icon(Icons.person),
                      isDense: true,
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Required Field';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Email',
                      //icon: Icon(Icons.person),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'MobileNo.',
                      hintText: 'MobileNo.',
                      //icon: Icon(Icons.person),
                      isDense: true,
                    ),
                    validator: (val) {
                      String patttern = r'(^[0-9]*$)';
                      RegExp regExp = RegExp(patttern);
                      if (val!.isEmpty) {
                        return 'Fill Valid MobileNo';
                      } else if (val.length != 10) {
                        return 'Fill Valid MobileNo';
                      } else if (!regExp.hasMatch(val)) {
                        return 'Fill Valid MobileNo';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Address',
                      hintText: 'Your Address',
                      //icon: Icon(Icons.person),
                      isDense: true,
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Fill Your Address';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: TextFormField(
                    controller: pincode,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    // keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'PinCode',
                      hintText: 'PinCode',
                      //icon: Icon(Icons.person),
                      isDense: true,
                    ),
                    validator: (val) {
                      String pattern = r'(^[0-9]*$)';
                      RegExp regExp = RegExp(pattern);
                      if (val!.isEmpty) {
                        return 'Enter Valid Pincode';
                      } else if (val.length != 6) {
                        return 'Enter Valid Pincode';
                      } else if (!regExp.hasMatch(val)) {
                        return 'Enter Valid Pincode';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    onPressed: () {
                      _submit(address.text, pincode.text);
                    },
                    child: Text('Save Add'.toUpperCase()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
