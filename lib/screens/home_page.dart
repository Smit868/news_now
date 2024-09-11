import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart'; // Import the DotsIndicator package

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Now',
      debugShowCheckedModeBanner: false,
      home: NewsPage(),
    );
  }
}

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int currentIndexPage = 0; // Track the current page index
  final int pageLength = 3; // Total number of pages

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'News',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: 'Now',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Top categories section
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildCategoryTile('assets/images/sports.jpeg', 'SPORTS'),
                buildCategoryTile('assets/images/business.webp', 'BUSINESS'),
                buildCategoryTile('assets/images/bollywood.jpeg', 'BOLLYWOOD'),
                buildCategoryTile('assets/images/tech.jpeg', 'TECH'),
                buildCategoryTile('assets/images/Health.jpeg', 'HEALTH'),
                buildCategoryTile('assets/images/World.jpeg', 'WORLD'),
              ],
            ),
          ),
          SizedBox(height: 0),

          // Breaking News Section
          Text(
            'Breaking News!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 18),
          CarouselSlider(
            options: CarouselOptions(
              height: screenHeight * 0.25,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndexPage = index; // Update the current index
                });
              },
            ),
            items: [
              buildNewsSlider('assets/images/news1.jpg'),
              buildNewsSlider('assets/images/news2.jpg'),
              buildNewsSlider('assets/images/news3.jpg'),
            ],
          ),
          // Dots Indicator
          Center(
            child: DotsIndicator(
              dotsCount: pageLength,
              position: currentIndexPage.toInt(),
              decorator: DotsDecorator(
                spacing: const EdgeInsets.all(10.0),
                activeColor: Colors.blue,
                color: Colors.grey,
              ),
            ),
          ),

          SizedBox(height: 10),

          // Trending News Section
          Text(
            'Trending News!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            selectionColor: Colors.amberAccent,
          ),
          SizedBox(height: 16),
          buildTrendingNews('assets/images/trending1.webp',
              'Pixel 9 is the latest flagship smartphone series of Google...'),
          buildTrendingNews('assets/images/trending2.webp',
              'NASA has issued an urgent alert about a near Earth object...'),
          buildTrendingNews('assets/images/trending3.jpg',
              'NASA has issued an urgent alert about a near Earth object...'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        onTap: (index) {
          HomePage();
        },
      ),
    );
  }

  // Helper method to build category tiles
  Widget buildCategoryTile(String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Helper method to build news slider items without headlines
  Widget buildNewsSlider(String imagePath) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      },
    );
  }

  // Helper method to build trending news items
  Widget buildTrendingNews(String imagePath, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              height: 80,
              width: 80,
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
    );
  }
}
