import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/NewsChannelHeadlineModel.dart';

class NewsRepository {
  Future<NewsChannelHeadlineModel> fetchNewsChannelApiIntegeration() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=661489c3778d4762b0c870389a78deef';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlineModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
