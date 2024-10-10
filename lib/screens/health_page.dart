import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_now/screens/business_page.dart';
import 'dart:convert';
// Shared bookmark page

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
