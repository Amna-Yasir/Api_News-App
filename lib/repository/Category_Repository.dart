import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/Category_channel_model.dart';

class CategoryRepository {
  Future<category_channel_model> fetchCategoryApiIntegeration(
      String categoryname) async {
    String url =
        'https://newsapi.org/v2/everything?q=${categoryname}&apiKey=661489c3778d4762b0c870389a78deef';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return category_channel_model.fromJson(body);
    }
    throw Exception('Error');
  }
}
