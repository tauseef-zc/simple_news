import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/services/news_service.dart';
import 'package:news_app/features/home/models/news.dart';

class NewsHeadlineNotifier extends StateNotifier<List<News>> {
  NewsHeadlineNotifier() : super([]);
  bool _isLoading = false;

  Future<void> seedFresh() async {
      state = [];
      await fetchHeadlines();
  }

  Future<void> fetchHeadlines() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      state = await NewsService.fetchHeadlines();

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

final newsHeadlineProvider = StateNotifierProvider<NewsHeadlineNotifier, List<News>>((ref) {
  return NewsHeadlineNotifier();
});

