import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/features/home/models/news.dart';

class NewsService {
  static const String _apiKey = '91c577f496774e4fbe1f9b4abb79f19a';
  static const String _baseUrl = 'https://newsapi.org/v2';

  static Future<List<News>> fetchHeadlines({int page = 1, int pageSize = 20}) async {
    final response = await http.get(Uri.parse('$_baseUrl/top-headlines?country=us&page=$page&pageSize=$pageSize&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['articles'] as List).map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load headlines');
    }
  }

  static Future<List<News>> fetchLatestNews(String category, {int page = 1, int pageSize = 20}) async {
    final response = await http.get(Uri.parse('$_baseUrl/top-headlines?category=$category&page=$page&pageSize=$pageSize&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['articles'] as List).map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load latest news');
    }
  }

  static Future<List<News>> fetchCategoryNews(String category, {int page = 1, int pageSize = 20}) async {
    final response = await http.get(Uri.parse('$_baseUrl/top-headlines?category=$category&page=$page&pageSize=$pageSize&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['articles'] as List).map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load category news');
    }
  }
}