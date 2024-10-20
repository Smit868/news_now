// global.dart

// Global list for bookmarked articles
List<NewsArticle> bookmarkedArticles = [];

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

  get url => null;
}
