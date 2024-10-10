import 'package:flutter/material.dart';
import 'package:news_now/screens/home_page.dart';
// import 'package:share_plus/share_plus.dart'; // Import share_plus

import 'recentnews_page.dart'; // Import the main file where your `bookmarkedArticles` is defined

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        HomePageContent()))); // Go back to the previous page
          },
        ),
        centerTitle: true,
        title: Text(
          'BOOKMARK',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20, // Adjusted font size
          ),
        ),
      ),
      body: bookmarkedArticles.isEmpty
          ? Center(
              child: Text(
                'No bookmarks available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: bookmarkedArticles.length,
              itemBuilder: (context, index) {
                final article = bookmarkedArticles[index];
                return BookmarkNewsCard(
                  article: article,
                  onBookmarkRemoved: () {
                    // Remove the article from bookmarks
                    setState(() {
                      bookmarkedArticles.remove(article);
                    });
                    // Show "Bookmark removed" snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Bookmark removed'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class BookmarkNewsCard extends StatelessWidget {
  final NewsArticle article;
  final VoidCallback onBookmarkRemoved;

  BookmarkNewsCard({required this.article, required this.onBookmarkRemoved});

  // void shareArticle() {
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
            child: Image.network(article.urlToImage, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article.title,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(article.description),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.bookmark_remove),
                onPressed: () {
                  onBookmarkRemoved();
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
