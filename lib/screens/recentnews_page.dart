import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecentNewsPage(),
    );
  }
}

class RecentNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RECENT NEWS'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          // First News Item
          NewsCard(
            imageUrl: 'https://example.com/justice_protest.png',
            title: 'Kolkata doctor rape-murder case LIVE updates:',
            description:
                'Amid nationwide protests against the rape and murder of a trainee doctor at RG Kar hospital in Kolkata, the Supreme Court is set to hear the case.',
          ),
          SizedBox(height: 16.0),
          // Second News Item (Placeholder for example)
          NewsCard(
            imageUrl: 'https://example.com/pm_meeting.png',
            title: 'Indian PM meets Ukraine President for peace talks',
            description:
                'In a historic meeting, the Indian Prime Minister welcomed the President of Ukraine for peace talks regarding ongoing conflicts.',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  NewsCard({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(imageUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(description),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
