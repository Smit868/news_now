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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Breaking News',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          // First News Item
          NewsCard(
            imageUrl:
                'https://www.hindustantimes.com/ht-img/img/2024/09/14/550x309/India-Rape-Outrage-6_1726302161245_1726302196079.jpg',
            title: 'Kolkata doctor rape-murder case LIVE updates:',
            description:
                'Amid nationwide protests against the rape and murder of a trainee doctor at RG Kar hospital in Kolkata, the Supreme Court is set to hear the case.',
          ),
          SizedBox(height: 16.0),
          // Second News Item (Placeholder for example)
          NewsCard(
            imageUrl:
                'https://akm-img-a-in.tosshub.com/indiatoday/images/story/202406/pm-modi-with-ukrainian-president-volodymyr-zelenskyy-142504345-16x9_0.jpg?VersionId=wBaWdcvq_rX0WAa3lWIUZlK4Fy3wr.c2',
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
