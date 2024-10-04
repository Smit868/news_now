import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// Import share_plus
// Import your bookmark page

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
  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=1a261517516e45e3867d3aba993f1c6a'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final articles = jsonResponse['articles'] as List;
      return articles
          .map((article) => NewsArticle.fromJson(article))
          .take(10) // Limit to 10 articles
          .toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

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
          'BREAKING NEWS',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load news'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available'));
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return NewsCard(article: article);
              },
            );
          }
        },
      ),
    );
  }
}

List<NewsArticle> bookmarkedArticles =
    []; // Global list for bookmarked articles

class NewsCard extends StatefulWidget {
  final NewsArticle article;

  NewsCard({required this.article});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool liked = false;
  int likeCount = 0;
  bool isBookmarked = false;

  void toggleButton() {
    setState(() {
      liked = !liked;
      likeCount += liked ? 1 : -1;
    });
  }

  void toggleBookmark(BuildContext context) {
    // Check if the article is already in the bookmarked list
    if (!bookmarkedArticles.contains(widget.article)) {
      setState(() {
        isBookmarked = true;
        bookmarkedArticles
            .add(widget.article); // Add article to bookmarked list
      });
      // Show snackbar: "Bookmark added"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bookmark added'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Show snackbar: "Already added in bookmark"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Already added in bookmark'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // void shareArticle() {
  //   final article = widget.article;
  //   Share.share(
  //       'Check out this news: ${article.title}\n\n${article.description}\n\nRead more at: ${article.urlToImage}');
  // }

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
            child: Image.network(widget.article.urlToImage, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.article.title,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(widget.article.description),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: toggleButton,
                    child: liked
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_outline),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '$likeCount',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => toggleBookmark(context),
                child: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.black : null,
                ),
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {}, // Implement share functionality here
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;

  NewsArticle({
    required this.title,
    required this.description,
    required this.urlToImage,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No title available',
      description: json['description'] ?? 'No description available',
      urlToImage: json['urlToImage'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsArticle &&
        other.title == title &&
        other.description == description &&
        other.urlToImage == urlToImage;
  }

  @override
  int get hashCode =>
      title.hashCode ^ description.hashCode ^ urlToImage.hashCode;
}
