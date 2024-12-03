import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/services/news_service.dart';
import 'package:news_app/features/home/models/news.dart';

class LatestNewsNotifier extends StateNotifier<List<News>> {
    LatestNewsNotifier() : super([]);

    int _currentPage = 1;
    bool _isLoading = false;

    Future<void> fetchLatestNews() async {
        _currentPage = 1;
        state = [];
        await fetchNextPage();
    }

    Future<void> fetchNextPage() async {
        if (_isLoading) return;

        _isLoading = true;
        try {
            final newNews = await NewsService.fetchLatestNews('general', page: _currentPage);
            if (newNews.isNotEmpty) {
                state = List.from(state)..addAll(newNews);
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

final latestNewsProvider = StateNotifierProvider<LatestNewsNotifier, List<News>>((ref) {
    return LatestNewsNotifier();
});