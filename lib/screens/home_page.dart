import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:news_now/screens/bollywood_page.dart';
import 'package:news_now/screens/bookmark_page.dart';
import 'package:news_now/screens/business_page.dart';
import 'package:news_now/screens/profile_page.dart';
import 'package:news_now/screens/sports_page.dart';
import 'package:news_now/screens/trendingnews_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndexPage = 0;
  final int pageLength = 3;
  int _selectedIndex = 0;

  // List of pages to navigate to
  final List<Widget> _pages = [
    HomePageContent(), // This is the home content without Scaffold
    BookmarkPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
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
            )
          : null, // AppBar is only shown on the HomePage
      body: _pages[_selectedIndex], // Switching pages based on selected index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
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
}

// Extracting Home Page content to a separate widget
class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  int currentIndexPage = 0;
  final int pageLength = 3;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              buildCategoryTile('assets/images/sports.jpeg', 'SPORTS', context),
              buildCategoryTile(
                  'assets/images/business.webp', 'BUSINESS', context),
              buildCategoryTile(
                  'assets/images/bollywood.jpeg', 'BOLLYWOOD', context),
              buildCategoryTile('assets/images/tech.jpeg', 'TECH', context),
              buildCategoryTile('assets/images/Health.jpeg', 'HEALTH', context),
              buildCategoryTile('assets/images/World.jpeg', 'WORLD', context),
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
            height: MediaQuery.of(context).size.height * 0.25,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndexPage = index;
              });
            },
          ),
          items: [
            buildNewsSlider(
              'assets/images/news1.jpg',
              'Breaking: Major Event in City',
            ),
            buildNewsSlider(
              'assets/images/news2.jpg',
              'Business Growth Hits New Highs',
            ),
            buildNewsSlider(
              'assets/images/news3.jpg',
              'Sports Highlights: Football Finals',
            ),
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
        buildBookmarkCard(
          screenWidth,
          'assets/images/trending1.webp',
          'Mahindra has taken the entire country by storm with the launch of the brand-new Thar Roxx. This five-seater, five-door version of the Thar.',
        ),
        buildBookmarkCard(
          screenWidth,
          'assets/images/trending2.webp',
          'S&P raises rating, outlook on Tata Group companies on hopes of higher support from parent.',
        ),
        buildBookmarkCard(
          screenWidth,
          'assets/images/trending3.jpg',
          'Stree 2 Box Office Trends: Shraddha Kapoor and Rajkummar Rao\'s film enters 250 crore club in 6 days.',
        ),
        buildBookmarkCard(
          screenWidth,
          'assets/images/trending1.webp',
          'Call Me Bae Trailer: Ananya Panday\'s relaunch reminds fans of Emily In Paris and Aisha; Janhvi, Suhana shower love.',
        ),
      ],
    );
  }

  // Helper method to build category tiles
  Widget buildCategoryTile(
      String imagePath, String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (title == 'SPORTS') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SportsPage(),
                  ),
                );
              } else if (title == 'BUSINESS') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusinessNewsPage(),
                  ),
                );
              } else if (title == 'BOLLYWOOD') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => bollywoodNewsPage(),
                  ),
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
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

  // Method to build the news slider with image and text overlay
  Widget buildNewsSlider(String imagePath, String newsTitle) {
    return GestureDetector(
      onTap: () {
        // Navigate to a new page on tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrendingNewsPage(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
            ),
            // Text overlay
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                color: Colors.black54.withOpacity(0.7),
                child: Text(
                  newsTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build trending news items
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
                width: screenWidth * 0.3,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                description,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// NewsDetailPage to show detailed news content
class NewsDetailPage extends StatelessWidget {
  final String imagePath;
  final String newsTitle;

  NewsDetailPage({required this.imagePath, required this.newsTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: Column(
        children: [
          Image.asset(imagePath),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              newsTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Additional content for the news detail
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Detailed content about the news goes here. This is just placeholder text.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
