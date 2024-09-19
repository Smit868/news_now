import 'package:flutter/material.dart';

class SportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Sample data for sports news
    List<Map<String, String>> sportsNews = [
      {
        'image': 'assets/images/news1.jpg',
        'title':
            'CAS released a 24-page document explaining the reason behind dismissing Vinesh Phogat’s appeal for an Olympic silver medal.',
      },
      {
        'image': 'assets/images/news2.jpg',
        'title':
            'Meanwhile, Lyon asserted that he watched Jaiswal closely during the England Tests, during which he found his batting amazing.',
      },
      {
        'image': 'assets/images/news3.jpg',
        'title':
            'Pro Kabaddi League Player Auctions Report Card: Who got an A+?',
      },
      {
        'image': 'assets/images/news1.jpg',
        'title':
            'Pat Cummins to take a break, unfinished business in Nathan Lyon\'s mind',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'SPORTS',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: sportsNews.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: buildNewsCard(
              context,
              sportsNews[index]['image']!,
              sportsNews[index]['title']!,
              screenWidth,
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildNewsCard(BuildContext context, String imagePath, String title,
      double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              height: screenWidth * 0.25,
              width: screenWidth * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
