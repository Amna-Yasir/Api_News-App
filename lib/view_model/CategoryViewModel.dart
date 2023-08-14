import 'package:news_app/models/Category_channel_model.dart';
import 'package:news_app/repository/Category_Repository.dart';

class CategoryViewModel {
  final _res = CategoryRepository();
  Future<category_channel_model> fetchCategoryApiIntegeration(
      String channelname) async {
    final response = _res.fetchCategoryApiIntegeration(channelname);
    return response;
  }
}
