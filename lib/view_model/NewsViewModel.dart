import 'package:news_app/models/NewsChannelHeadlineModel.dart';
import 'package:news_app/repository/NewsRepository.dart';

class NewsViewModel {
  final _res = NewsRepository();
  Future<NewsChannelHeadlineModel> fetchNewsChannelApiIntegeration() async {
    final response = _res.fetchNewsChannelApiIntegeration();
    return response;
  }
}
