import 'package:flutter/material.dart';
import 'package:news_now/screens/home_page.dart';

class Land extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive dimensions
    final imageHeight = screenHeight * 0.5; // 50% of the screen height
    final titleFontSize = screenWidth * 0.08; // 8% of the screen width
    final subtitleFontSize = screenWidth * 0.05; // 5% of the screen width
    final buttonFontSize = screenWidth * 0.04; // 4% of the screen width
    final padding = screenWidth * 0.05; // 5% of the screen width for padding

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
              SizedBox(height: screenHeight * 0.03), // 3% of the screen height
              Text(
                'News from around the world for you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // 2% of the screen height
              Text(
                'Best time to read, take your time to read a little more of this world',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // 3% of the screen height
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02), // 2% of the screen height
                  child: Text(
                    'Get started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: buttonFontSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
