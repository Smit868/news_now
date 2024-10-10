import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// Use the shared bookmark page

// Global list for bookmarked articles (same as in the Recent News page)
List<NewsArticle> bookmarkedArticles = [];

class Sportspage extends StatefulWidget {
  @override
  _SportspageState createState() => _SportspageState();
}

class _SportspageState extends State<Sportspage> {
  // Fetching sports news with API
  Future<List<NewsArticle>> fetchSportsNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=sports&country=us&apiKey=1a261517516e45e3867d3aba993f1c6a'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final articles = jsonResponse['articles'] as List;
      return articles
          .map((article) {
            return NewsArticle.fromJson(
                {...article, 'category': 'Sports News'});
          })
          .take(10)
          .toList(); // Limit the news to 10 articles
    } else {
      throw Exception('Failed to load sports news');
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
        title: Text(
          'SPORTS NEWS',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: fetchSportsNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load sports news'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No sports news available'));
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
  int likeCount = 0;
  bool isBookmarked = false;

  // Toggle the like button
  void toggleLike() {
    setState(() {
      liked = !liked;
      likeCount += liked ? 1 : -1;
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
          duration: Duration(seconds: 0),
        ),
      );
    } else {
      // Show snackbar: "Already added in bookmark"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Already bookmarked'),
          duration: Duration(seconds: 0),
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
          // Like, bookmark, and share buttons
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: toggleLike,
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

// NewsArticle model (same as in Recent News page)
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
