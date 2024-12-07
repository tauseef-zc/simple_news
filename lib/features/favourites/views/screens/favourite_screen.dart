import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/main.dart';
import 'package:news_app/widgets/app_navigation_bar.dart';
import 'package:news_app/widgets/page_title.dart';
import '../../controllers/favorite_news_controller.dart';
import '../widgets/news_card.dart';

class FavoriteNewsScreen extends ConsumerWidget {
  const FavoriteNewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteNews = ref.watch(favoriteNewsProvider);

    return SafeArea(
        child: Scaffold(
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  const PageTitle(title: "Favourite News"),
                  const Text('You can find your favorite news here.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                  )),
                  const SizedBox(height: 15),
                  Expanded(
                    child: favoriteNews.isEmpty
                        ? const Center(
                      child: Text('No favorite news available.'),
                    )
                        : GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.5/3.2,
                      ),
                      itemCount: favoriteNews.length,
                      itemBuilder: (context, index) {
                        final news = favoriteNews[index];
                        return NewsCard(
                          news: news,
                          onDelete: () => ref
                              .read(favoriteNewsProvider.notifier)
                              .deleteFavorite(news.id),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        bottomNavigationBar: const AppNavigationBar(currentIndex: 3),
        ));
  }
}
