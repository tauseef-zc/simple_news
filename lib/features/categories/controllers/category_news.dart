import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/services/news_service.dart';
import 'package:news_app/features/home/models/news.dart';

final categoryNewsProvider = StateNotifierProvider<CategoryNewsNotifier, Map<String, List<News>>>((ref) {
  return CategoryNewsNotifier();
});


class CategoryNewsNotifier extends StateNotifier<Map<String, List<News>>> {
  CategoryNewsNotifier() : super({});

  int _currentPage = 1;
  bool _isLoading = false;

  void resetState() {
    state = <String, List<News>>{};
  }

  Future<void> fetchCategoryNews(String category, String sortBy) async {
    _currentPage = 1;
    state = {
      ...state,
      category: [],
    };
    await categoryNextPage(category, sortBy);
  }

  Future<void> categoryNextPage(String category, String sortBy) async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      final newNews = await NewsService.fetchCategoryNews(category, page: _currentPage, sortBy: sortBy);
      if (newNews.isNotEmpty) {
        state = {
          ...state,
          category: List.from(state[category] ?? [])..addAll(newNews),
        };
        _currentPage++;
      }
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print(e);
      }
    } finally {
      _isLoading = false;
    }
  }
}
