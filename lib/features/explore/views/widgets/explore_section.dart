import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/explore/controllers/explore_controller.dart';
import 'package:news_app/features/explore/controllers/search_controller.dart';
import 'package:news_app/features/explore/views/widgets/trending_card.dart';
import 'package:news_app/utils/theme.dart';

class ExploreSection extends ConsumerWidget {
  const ExploreSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final trendingNews = ref.watch(exploreProvider);
    final trendingNewsNotifier = ref.read(exploreProvider.notifier);
    final searchNotifier = ref.read(searchNewsProvider.notifier);

    List<String> popularTags = [
      '#BreakingNews',
      '#WorldNews',
      '#Politics',
      '#Sports',
      '#Entertainment',
      '#Technology',
      '#Health',
      '#Business',
      '#ClimateChange',
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (trendingNews.isEmpty) {
        trendingNewsNotifier.trendingTitles();
      }
    });

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Tags',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: popularTags.map(
                  (tag) => GestureDetector(
                    onTap: () {
                      searchNotifier.setSearchTerm(tag);
                      searchNotifier.setShowSearch();
                    },
                    child: Chip(
                      label: Text(tag),
                    ),
                  ),
            ).toList(),
          ),
          const SizedBox(height: 18),
          const Text(
            'Trending',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          trendingNews.isEmpty
              ? Center(
              child: CircularProgressIndicator(color: Theme.of(context).primaryColor)
          ): Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2 / 2.5,
              ),
              itemCount: trendingNews.length,
              itemBuilder: (context, index) => TrendingCard(news: trendingNews, id: index),
            ),
          )
        ],
      ),
    );
  }
}