import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/features/favourites/controllers/favorite_news_controller.dart';
import 'package:news_app/features/home/models/news.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailScreen extends ConsumerWidget {
  final News news;

  const NewsDetailScreen(
      this.news, {
        super.key,
      });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteNotifier = ref.read(favoriteNewsProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildCoverImage(news),
          _buildBackButton(context),
          _scrollableSheet(news, favoriteNotifier),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Share.share("${news.description} - ${news.url}", subject: news.title);
          },
          tooltip: 'Share',
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: const Icon(Icons.share, color: Colors.white),
      ),
    );
  }

  Widget _buildCoverImage(News news) {
     return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Builder(builder: (context) {
        return Image.network(
          news.urlToImage ?? "https://placehold.co/600x400.jpg?text=image",
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          fit: BoxFit.cover,
        );
      }),
    );
  }

  Widget _scrollableSheet(News news, FavoriteNewsNotifier favoriteNotifier) {
    final publishDate = Jiffy.parseFromDateTime(news.publishedAt).fromNow();
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
        maxChildSize: 1.0,
        minChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric( vertical: 30, horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -4),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Text(
                          news.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 30
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          bool status = await favoriteNotifier.addFavorite(news);
                          if (status) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("News added to favorites")));
                          }
                        },
                        child: Icon(
                          news.isSaved == true ? Icons.bookmark : Icons.bookmark_border_rounded,
                          size: 40,
                          weight: 1,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(publishDate,
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      )
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: const Icon(Icons.person, size: 28),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Text(
                          news.author ?? "",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    news.content ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Source: ${news.source ?? ""}",
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
    );
  }
}
