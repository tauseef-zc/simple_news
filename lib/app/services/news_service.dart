import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:news_app/features/home/models/news.dart';
import 'package:news_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsService {


  static Future<List<News>> fetchHeadlines(
      {int page = 1, int pageSize = 20}
  ) async {
    final response = await http.get(
        Uri.parse(
            '$baseUrl/top-headlines?country=us&page=$page&'
                'pageSize=$pageSize&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return formatData((data['articles'] as List));
    } else {
      throw Exception('Failed to load headlines');
    }
  }

  static Future<List<News>> searchNews(
      {required String query,
        int page = 1,
        int pageSize = 20,
        String sortBy = "publishedAt"
      }
  ) async {

    final search = query.replaceAll("#", "");
    final response = await http.get(
        Uri.parse(
            '$baseUrl/everything?q=$search&sortBy=$sortBy&page=$page&pageSize='
                '$pageSize&apiKey=$apiKey'
        )
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return formatData((data['articles'] as List));
    } else {
      return [];
    }
  }

  static Future<List<News>> fetchTrendingNews(
      {int page = 1, int pageSize = 6}
  ) async {
    final response = await http.get(
        Uri.parse('$baseUrl/everything?q=latest+trending&sortBy=publishedAt&'
            'page=$page&pageSize=$pageSize&apiKey=$apiKey')
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return formatData((data['articles'] as List));
    } else {
      throw Exception('Failed to load latest news');
    }
  }

  static Future<List<News>> fetchLatestNews(
      {int page = 1, int pageSize = 20}
  ) async {
    final response = await http.get(
        Uri.parse(
            '$baseUrl/everything?q=latest&sortBy=publishedAt&page='
                '$page&pageSize=$pageSize&apiKey=$apiKey'
        ));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return formatData((data['articles'] as List));
    } else {
      throw Exception('Failed to load latest news');
    }
  }

  static Future<List<News>> fetchCategoryNews(
      String category,
      {int page = 1, int pageSize = 20, String sortBy = "publishedAt"}
  ) async {
    String categoryItem = category.toLowerCase();

    final response = await http.get(
        Uri.parse(
            '$baseUrl/top-headlines?category=$categoryItem&sortBy=$sortBy&page='
                '$page&pageSize=$pageSize&apiKey=$apiKey'
        ));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return formatData((data['articles'] as List));
    } else {
      throw Exception('Failed to load category news');
    }
  }


  static Future<List<News>> formatData(List data) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    bool isFavourite = false;
    Future<List<String>?> favourites= prefs.getStringList('favourites');

    return data
        .where((json) => json['id'] != 'none' && json['title'] != '[Removed]')
        .map((json){
          json['id'] = Random().nextInt(1000000);
          isFavourite = false;
          favourites.then((value) => isFavourite = value!.contains(json['title']));
          json['isSaved'] = isFavourite;
          return News.fromJson(json);
        })
        .toList();
  }
}