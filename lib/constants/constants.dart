import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

showLoaderDialogue(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.red,
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("Loading"),
            ),
          ],
        ),
      );
    }),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Both Fields are empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email Fields are empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password Fields are empty");
    return false;
  } else {
    return true;
  }
}

bool regValidation(String email, String password, String name) {
  if (email.isEmpty && password.isEmpty && name.isEmpty) {
    showMessage("Both Fields are empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email Fields are empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password Fields are empty");
    return false;
  } else if (name.isEmpty) {
    showMessage("UserName Fields are empty");
    return false;
  } else {
    return true;
  }
}
