import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/app/routes/route_provider.dart';
import 'package:news_app/app/routes/routes.dart';
import 'package:news_app/features/home/models/news.dart';

class TrendingCard extends StatelessWidget {
  final int id;
  final List<News> news;

  const TrendingCard({
    super.key,
    required this.news,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final publishDate = Jiffy.parseFromDateTime(news[id].publishedAt).fromNow();
    return InkWell(
        onTap: () {
          context.pushNamed(singleNewsRoute,
            extra: news[id]
          );
        },
        child: Card(
        shadowColor: Colors.white,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    news[id].urlToImage,
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news[id].title,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      publishDate,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}