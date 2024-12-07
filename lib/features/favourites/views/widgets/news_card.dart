import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/app/routes/routes.dart';
import '../../../home/models/news.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback onDelete;

  const NewsCard({super.key, required this.news, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(singleNewsRoute, extra: news);
      },
      child: Card(
        elevation: 4,
        shadowColor: Colors.white,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      news.urlToImage,
                      width: double.infinity,
                      height: 150,
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
                        news.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        Jiffy.parseFromDateTime(news.publishedAt).fromNow(),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // TextButton.icon(
                      //   onPressed: onDelete,
                      //   icon: const Icon(Icons.delete, color: Colors.red),
                      //   label: const Text('Remove', style: TextStyle(color: Colors.red)),
                      // ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}