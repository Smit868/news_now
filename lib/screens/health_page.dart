import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Global list for bookmarked articles (same as in other pages)
List<NewsArticle> bookmarkedArticles = [];

class HealthNewsPage extends StatefulWidget {
  @override
  _HealthNewsPageState createState() => _HealthNewsPageState();
}

class _HealthNewsPageState extends State<HealthNewsPage> {
  Future<List<NewsArticle>> fetchHealthNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=health&country=us&apiKey=1a261517516e45e3867d3aba993f1c6a'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final articles = jsonResponse['articles'] as List;
      return articles
          .map((article) => NewsArticle.fromJson(article))
          .take(10)
          .toList(); // Limit to 10 articles
    } else {
      throw Exception('Failed to load health news');
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
        centerTitle: true,
        title: Text('HEALTH NEWS', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: fetchHealthNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load health news'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No health news available'));
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

// NewsCard widget for displaying individual news items
class NewsCard extends StatefulWidget {
  final NewsArticle article;

  NewsCard({required this.article});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool liked = false;
  bool isBookmarked = false;

  // Toggle the like button
  void toggleLike() {
    setState(() {
      liked = !liked;
    });
  }

  // Toggle bookmark functionality
  void toggleBookmark(BuildContext context) {
    // Check if the article is already in the bookmarked list
    if (!bookmarkedArticles.contains(widget.article)) {
      setState(() {
        isBookmarked = true;
        bookmarkedArticles.add(widget.article); // Add to bookmarked list
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
          content: Text('Already bookmarked'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image display
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(widget.article.urlToImage, fit: BoxFit.cover),
          ),
          // Title display
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.article.title,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ),
          // Description display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(widget.article.description),
          ),
          // Like, bookmark, and share buttons (without moving icons)
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: toggleLike,
                child: Icon(
                  liked ? Icons.favorite : Icons.favorite_outline,
                  color: liked ? Colors.red : null,
                ),
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
                onPressed: () {
                  // Implement share functionality here
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// NewsArticle model
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
