import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/services/news_service.dart';
import '../../home/models/news.dart';

final exploreProvider = StateNotifierProvider<ExploreController, List<News>>((ref) => ExploreController());

class ExploreController extends StateNotifier<List<News>> {
  ExploreController() : super([]);

  bool _isLoading  = false;

  Future<void> trendingTitles() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      state = await NewsService.fetchTrendingNews();

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