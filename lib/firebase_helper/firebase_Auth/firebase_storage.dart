import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageHelper {
  static FirebaseStorageHelper instance = FirebaseStorageHelper();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadUserImage(File image) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    TaskSnapshot taskSnapshot = _storage.ref(userId).putFile(image).snapshot;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    print(imageUrl + "hello guys");
    return imageUrl;
  }
}