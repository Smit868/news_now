import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BusinessNewsPage(),
    );
  }
}

class BusinessNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BUSINESS'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          // First News Item
          NewsCard(
            imageUrl: 'https://example.com/tata_logo.png',
            title: 'S&P raises rating, outlook on Tata Group companies',
            description:
                'S&P raises rating and outlook on Tata Group companies on hopes of higher support from the parent.',
          ),
          SizedBox(height: 16.0),
          // Second News Item
          NewsCard(
            imageUrl: 'https://example.com/mahindra_thar.png',
            title: 'Mahindra launches the Thar Roxx',
            description:
                'Mahindra has taken the entire country by storm with the launch of the brand-new Thar Roxx. This five-seater, five-door version of the Thar is trending.',
          ),
          SizedBox(height: 16.0),
          // Third News Item
          NewsCard(
            imageUrl: 'https://example.com/sbi_nifty.png',
            title: 'SBI Life Insurance Climbs 5% To Top Nifty',
            description:
                'SBI Life Insurance climbs 5% to top the Nifty, while ONGC is the biggest drag on the index.',
          ),
          SizedBox(height: 16.0),
          // Fourth News Item
          NewsCard(
            imageUrl: 'https://example.com/gold_rates.png',
            title: 'Gold Rates Announced for August 19',
            description:
                'Gold rates announced for August 19. Check the price of 22 carat gold in your city today.',
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
