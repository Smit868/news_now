import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoreData {
  Future<String> saveData({
    required String name,
    required String email,
    required String phoneno,
    required String birthdate,
    required Uint8List file, // Image as bytes
  }) async {
    try {
      // Get the current authenticated user
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('No authenticated user');

      // 1. Upload the profile image to Firebase Storage
      String filePath = 'profileImages/${user.uid}/profile.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child(filePath);
      UploadTask uploadTask = storageRef.putData(file);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL of the uploaded image
      String profileImageUrl = await snapshot.ref.getDownloadURL();

      // 2. Store user data in Firestore (with the profile image URL)
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'phoneno': phoneno,
        'birthdate': birthdate,
        'profileImageUrl': profileImageUrl,
      });

      return 'Profile data stored successfully!';
    } catch (e) {
      return 'Error: $e';
    }
  }
}
