import 'package:flutter/material.dart';
import 'package:news_now/main.dart';
import 'package:news_now/screens/home_page.dart';

class BookmarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          },
        ),
        centerTitle: true,
        title: Text(
          'BOOKMARK',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          buildBookmarkCard(
            screenWidth,
            'assets/images/news1.jpg',
            'Mahindra has taken the entire country by storm with the launch of the brand-new Thar Roxx. This five-seater, five-door version of the Thar.',
          ),
          buildBookmarkCard(
            screenWidth,
            'assets/images/news2.jpg',
            'S&P raises rating, outlook on Tata Group companies on hopes of higher support from parent.',
          ),
          buildBookmarkCard(
            screenWidth,
            'assets/images/news3.jpg',
            'Stree 2 Box Office Trends: Shraddha Kapoor and Rajkummar Rao\'s film enters 250 crore club in 6 days.',
          ),
          buildBookmarkCard(
            screenWidth,
            'assets/images/trending2.webp',
            'Call Me Bae Trailer: Ananya Panday\'s relaunch reminds fans of Emily In Paris and Aisha; Janhvi, Suhana shower love.',
          ),
        ],
      ),
    );
  }

  Widget buildBookmarkCard(
      double screenWidth, String imagePath, String description) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                height: 80,
                width: screenWidth * 0.25, // 25% of screen width
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                description,
                style: TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
