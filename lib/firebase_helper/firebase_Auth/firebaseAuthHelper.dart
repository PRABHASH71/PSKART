import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pskart/constants/constants.dart';
import 'package:pskart/models/userModel.dart';

import 'package:pskart/screens/auth_ui/login/login.dart';

import 'package:pskart/screens/home/home.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialogue(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();

      showMessage(error.code.toString());
      return false;
    }
  }

//REGISTER
  Future<bool> register(
      String email, String password, String name, BuildContext context) async {
    try {
      showLoaderDialogue(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      Usermodel usermodel = Usermodel(
          id: userCredential.user!.uid, name: name, email: email, image: null);

      _firestore.collection("users").doc(usermodel.id).set(usermodel.toJson());

      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();

      showMessage(error.code.toString());
      return false;
    }
  }

  void signout() async {
    await _auth.signOut();
  }
}
