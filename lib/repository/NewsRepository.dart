import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_now/Newsmodels/NewsTopHeadlineModel.dart';

class NewsRepository {
  Future<NewsTopHeadlineModel> fetchNewsTopHeadlineModelApi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=1a261517516e45e3867d3aba993f1c6a';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return NewsTopHeadlineModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }

  Future<NewsTopHeadlineModel> fetchTrendingNewsModel() async {
    String url =
        'https://newsapi.org/v2/top-headlines?category=science&country=us&apiKey=1a261517516e45e3867d3aba993f1c6a';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return NewsTopHeadlineModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }
}
