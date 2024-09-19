import 'package:flutter/material.dart';
import 'package:news_now/main.dart';
import 'package:news_now/screens/Login_page.dart';
import 'package:news_now/screens/home_page.dart';
import 'package:news_now/screens/signup_page.dart';

class Land extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final imageHeight = screenHeight * 0.7;
    final titleFontSize = screenWidth * 0.08;
    final subtitleFontSize = screenWidth * 0.05;
    final buttonFontSize = screenWidth * 0.05;
    final padding = screenWidth * 0.05;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  'assets/images/indiagate.jpg',
                  fit: BoxFit.cover,
                  height: imageHeight,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'News from around the world for you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Best time to read, take your time to read a little more of this world',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Distribute buttons evenly
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: Text(
                        ' Login ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: buttonFontSize,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: Text(
                        'SignUp',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: buttonFontSize,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
