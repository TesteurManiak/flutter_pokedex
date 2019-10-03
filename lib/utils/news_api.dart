import 'dart:convert';

import 'package:pokedex/models/article.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  final apiKey = "5cbc20a4a58a41bca753e07ed6cc0e8c";
  final endpointsEvery = "everything";
  final titleOnlyParam = "qInTitle";
  final languageParam = "language";
  final pageSizeParam = "pageSize";
  final sortByParam = "sortBy";
  final apiKeyParam = "apiKey";
  final apiUrl = "https://newsapi.org/v2";

  Future<List<ArticleModel>> fetchXArticles(int x) async {
    List<ArticleModel> articles = [];
    final response = await http.get(
        "$apiUrl/$endpointsEvery?$titleOnlyParam=pokemon&$languageParam=en&$pageSizeParam=$x&$sortByParam=publishedAt&$apiKeyParam=$apiKey");
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      if (json['status'] == "ok") {
        json['articles'].forEach((articleJson) {
          articles.add(ArticleModel.fromJson(articleJson));
        });
      }
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
