import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:news_now/Newsmodels/NewsTopHeadlineModel.dart';
import 'package:news_now/ViewModel/NewsViewModel.dart';
import 'package:news_now/screens/bollywood_page.dart';
import 'package:news_now/screens/bookmark_page.dart';
import 'package:news_now/screens/business_page.dart';
import 'package:news_now/screens/health_page.dart';
import 'package:news_now/screens/profile_page.dart';
import 'package:news_now/screens/recentnews_page.dart';
import 'package:news_now/screens/sports_page.dart';
import 'package:news_now/screens/technology_page.dart';
import 'package:news_now/screens/trendingnews_page.dart';
import 'package:news_now/screens/world_news.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageContent(),
    );
  }
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  int currentIndexPage = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    HomeScreen(),
    BookmarkPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentIndexPage == 0
          ? AppBar(
              toolbarHeight: 50,
              title: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'News ',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Now',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
            )
          : null,
      body: _pages[currentIndexPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndexPage,
        onTap: (index) {
          setState(() {
            currentIndexPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        SizedBox(
          height: screenSize.height * 0.12,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              buildCategoryTile('assets/images/sports.jpeg', 'SPORTS', context),
              buildCategoryTile(
                  'assets/images/business.webp', 'BUSINESS', context),
              buildCategoryTile(
                  'assets/images/bollywood.jpeg', 'BOLLYWOOD', context),
              buildCategoryTile(
                  'assets/images/tech.jpeg', 'TECHNOLOGY', context),
              buildCategoryTile('assets/images/Health.jpeg', 'HEALTH', context),
              buildCategoryTile('assets/images/World.jpeg', 'WORLD', context),
            ],
          ),
        ),
        SizedBox(height: screenSize.height * 0.00),
        Text(
          'Breaking News!',
          style: TextStyle(
              fontSize: screenSize.shortestSide * 0.06,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenSize.height * 0.02),
        FutureBuilder<NewsTopHeadlineModel>(
          future: NewsViewModel().fetchNewsTopHeadlineModelApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Failed to load breaking news');
            } else {
              var newsList = snapshot.data!.articles!.take(10).toList();
              return Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: screenSize.height * 0.25,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: screenSize.aspectRatio,
                      enableInfiniteScroll: true,
                    ),
                    items: newsList
                        .where((article) =>
                            article.urlToImage != null &&
                            article.urlToImage!.isNotEmpty)
                        .map((article) {
                      return buildNewsSlider(
                        article.urlToImage!,
                        article.title ?? 'No title available',
                        context, // Pass context here
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  DotsIndicator(
                    dotsCount: newsList.length,
                    position: 0,
                    decorator: DotsDecorator(
                      spacing: const EdgeInsets.all(4.0),
                      activeColor: Colors.blue,
                      color: Colors.grey,
                    ),
                  ),
                ],
              );
            }
          },
        ),
        SizedBox(height: screenSize.height * 0.02),
        Text(
          'Trending News!',
          style: TextStyle(
              fontSize: screenSize.shortestSide * 0.06,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenSize.height * 0.02),
        FutureBuilder<NewsTopHeadlineModel>(
          future: NewsViewModel().fetchNewsTopHeadlineModelApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Failed to load trending news');
            } else {
              var newsList = snapshot.data!.articles!.take(10).toList();
              return Column(
                children: newsList
                    .where((article) =>
                        article.urlToImage != null &&
                        article.urlToImage!.isNotEmpty)
                    .map((article) {
                  return buildBookmarkCard(
                    context,
                    screenSize.width,
                    article.urlToImage!,
                    article.title ?? 'No title available',
                  );
                }).toList(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget buildCategoryTile(
      String imagePath, String title, BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageSize = screenSize.width * 0.16;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              _navigateToCategoryPage(title, context);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                height: imageSize,
                width: imageSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _navigateToCategoryPage(String title, BuildContext context) {
    if (title == 'SPORTS') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Sportspage()),
      );
    } else if (title == 'BUSINESS') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BusinessNewsPage()),
      );
    } else if (title == 'BOLLYWOOD') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => bollywoodNewsPage()),
      );
    } else if (title == 'TECHNOLOGY') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => technologyPage()),
      );
    } else if (title == 'HEALTH') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => healthPage()),
      );
    } else if (title == 'WORLD') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => worldPage()),
      );
    }
  }

  Widget buildNewsSlider(
      String imagePath, String newsTitle, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecentNewsPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.end, // Align the text to the bottom
          children: [
            Container(
              width:
                  double.infinity, // Ensure the text container takes full width
              padding: const EdgeInsets.all(8.0),
              color: Colors.black54,
              child: Text(
                newsTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBookmarkCard(
      BuildContext context, double width, String imageUrl, String newsTitle) {
    return GestureDetector(
      onTap: () {
        // Navigate to the TrendingNewsPage when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrendingNewsPage()),
        );
      },
      child: Card(
        child: Row(
          children: [
            // Adding Padding around the image
            Padding(
              padding: const EdgeInsets.all(8.0), // Add padding as needed
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    8.0), // Optional: Round the image corners
                child: Image.network(
                  imageUrl,
                  width: width * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  newsTitle,
                  maxLines: 2, // Limit the text to two lines
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  style: TextStyle(fontSize: 16.0), // Optional styling
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
