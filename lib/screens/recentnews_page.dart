import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_now/global.dart';
import 'package:share_plus/share_plus.dart'; // Import the global bookmark list

class RecentNewsPage extends StatefulWidget {
  @override
  _RecentNewsPageState createState() => _RecentNewsPageState();
}

class _RecentNewsPageState extends State<RecentNewsPage> {
  Future<List<NewsArticle>> fetchRecentNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=1a261517516e45e3867d3aba993f1c6a'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final articles = jsonResponse['articles'] as List;
      return articles.map((article) {
        return NewsArticle.fromJson(article);
      }).toList(); // No limit for articles now
    } else {
      throw Exception('Failed to load recent news');
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
        title: Text('RECENT NEWS', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: fetchRecentNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load recent news'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recent news available'));
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

class NewsCard extends StatefulWidget {
  final NewsArticle article;

  NewsCard({required this.article});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool liked = false;

  @override
  void initState() {
    super.initState();
    liked = false; // Initialize liked state
  }

  void toggleLike() {
    setState(() {
      liked = !liked;
    });
  }

  void toggleBookmark(BuildContext context) {
    setState(() {
      if (bookmarkedArticles.contains(widget.article)) {
        bookmarkedArticles.remove(widget.article); // Remove from bookmarks
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bookmark removed')),
        );
      } else {
        bookmarkedArticles.add(widget.article); // Add to bookmarks
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bookmark added')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isBookmarked = bookmarkedArticles.contains(widget.article);

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
            child: Text(widget.article.title,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(widget.article.description),
          ),
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
                  final String shareContent =
                      '${widget.article.title}\n${widget.article}';
                  Share.share(shareContent,
                      subject: 'Check out this news article!');
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
