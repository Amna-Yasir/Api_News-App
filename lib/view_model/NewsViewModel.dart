import 'package:news_app/models/NewsChannelHeadlineModel.dart';
import 'package:news_app/repository/NewsRepository.dart';

class NewsViewModel {
  final _res = NewsRepository();
  Future<NewsChannelHeadlineModel> fetchNewsChannelApiIntegeration(
      String channelname) async {
    final response = _res.fetchNewsChannelApiIntegeration(channelname);
    return response;
  }
}
