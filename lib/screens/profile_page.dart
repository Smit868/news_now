import 'package:flutter/material.dart';
import 'package:news_now/screens/Login_page.dart';
import 'package:news_now/screens/home_page.dart'; // Assuming you have this file
import 'package:icon/icon.dart'; // Assuming you are using this package

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PROFILE"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(), // Navigate to HomePage
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              // Profile Picture
              CircleAvatar(
                child: Icon(Icons.person_off_outlined),
                radius: 50,
                backgroundColor: Colors.blue,
              ),
              SizedBox(height: 20),
              // Username
              buildTextFormField(Icons.person, "Username"),
              // Phone Number
              buildTextFormField(Icons.phone, "Phone Number"),
              // Email
              buildTextFormField(Icons.email, "E-mail"),
              // Birthdate
              buildTextFormField(Icons.calendar_today, "Birthdate"),
              // Password
              buildTextFormField(Icons.lock, "Password", isPassword: true),
              SizedBox(height: 5),
              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  // Define button functionality
                },
                child: Text("Edit Profile"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
              SizedBox(height: 20),
              // Logout Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the logout page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(), // Define LogoutPage
                    ),
                  );
                },
                child: Text("Logout"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Red color for Logout button
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build TextFormFields
  Widget buildTextFormField(IconData icon, String label,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
