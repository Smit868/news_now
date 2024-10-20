import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_now/resources/save_data.dart';
import 'package:news_now/screens/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? _image;
  String? profileImageUrl; // Store the profile image URL here

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProfileData(); // Fetch profile data when the page loads
  }

  // Fetch user profile data from Firestore and display it
  Future<void> fetchProfileData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No authenticated user');
      }

      // Fetch the user document from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phoneno'] ?? '';
        birthController.text = data['birthdate'] ?? '';

        // Fetch and display the profile image URL
        profileImageUrl = data['profileImageUrl'] ?? '';

        // If image exists, set the state to load it
        setState(() {}); // Trigger UI update with the fetched data
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  // Function to save the profile
  void saveProfile() async {
    String name = nameController.text;
    String email = emailController.text;
    String phoneno = phoneController.text;
    String birthdate = birthController.text;

    if (_image != null) {
      String response = await StoreData().saveData(
        name: name,
        email: email,
        phoneno: phoneno,
        birthdate: birthdate,
        file: _image!,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image')),
      );
    }
  }

  // Function to select an image
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Stack(
                children: [
                  // Display profile image: show from Firebase Storage URL if exists, else default avatar
                  profileImageUrl != null && profileImageUrl!.isNotEmpty
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(profileImageUrl!),
                        )
                      : _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 65,
                              backgroundImage: NetworkImage(
                                  'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg'),
                            ),
                  Positioned(
                    child: IconButton(
                      onPressed: selectImage,
                      icon: Icon(Icons.add_a_photo),
                    ),
                    bottom: -10,
                    left: 80,
                  ),
                ],
              ),
              SizedBox(height: 25),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'e-mail',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: birthController,
                decoration: InputDecoration(
                  hintText: 'Birthdate',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: saveProfile,
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
