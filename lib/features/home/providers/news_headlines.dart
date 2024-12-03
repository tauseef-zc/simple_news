

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/services/news_service.dart';
import 'package:news_app/features/home/models/news.dart';

final headlinesState = StateProvider<List<News>?>((ref) => null);

final headlinesProvider = FutureProvider.autoDispose<List<News>>((ref) async {
  final cachedData = ref.read(headlinesState.notifier).state;
  if (cachedData != null) {
    return cachedData;
  } else {
    final headlines = await NewsService.fetchHeadlines();
    ref.read(headlinesState.notifier).state = headlines;
    return headlines;
  }
});

