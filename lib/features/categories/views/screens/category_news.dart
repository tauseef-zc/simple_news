import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/categories/controllers/category_news.dart';
import 'package:news_app/features/home/views/widgets/latest_news_list.dart';
import 'package:news_app/widgets/page_title.dart';

class CategoryNewsScreen extends ConsumerStatefulWidget {
  final String category;

  const CategoryNewsScreen({super.key, required this.category});

  @override
  ConsumerState<CategoryNewsScreen> createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends ConsumerState<CategoryNewsScreen> {

  late String sortBy;

  @override
  void initState() {
    super.initState();

    sortBy = "publishedAt";
    // Fetch category news when the widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsList = ref.read(categoryNewsProvider)[widget.category] ?? [];
      if (newsList.isEmpty) {
        ref.read(categoryNewsProvider.notifier).fetchCategoryNews(widget.category, sortBy);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryNews = ref.watch(categoryNewsProvider);
    final categoryNewsNotifier = ref.read(categoryNewsProvider.notifier);
    final newsList = categoryNews[widget.category] ?? [];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text("News Categories"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await categoryNewsNotifier.fetchCategoryNews(widget.category, sortBy);
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent) {
                categoryNewsNotifier.categoryNextPage(widget.category, sortBy);
              }
              return false;
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PageTitle(title: widget.category),

                    ],
                  ),
                  Expanded(
                    child: newsList.isEmpty
                        ? Center(
                      child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
                    )
                        : ListView.builder(
                      itemCount: newsList.length,
                      itemBuilder: (context, index) {
                        if (index == newsList.length - 1) {
                          return Column(
                            children: [
                              LatestNewsList(news: [newsList[index]]),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
                              ),
                            ],
                          );
                        }
                        return LatestNewsList(news: [newsList[index]]);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}
