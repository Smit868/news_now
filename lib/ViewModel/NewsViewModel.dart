import 'package:news_now/Newsmodels/NewsTopHeadlineModel.dart';
import 'package:news_now/repository/NewsRepository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsTopHeadlineModel> fetchNewsTopHeadlineModelApi() async {
    return await _repo.fetchNewsTopHeadlineModelApi();
  }
}
