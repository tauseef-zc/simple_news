import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/home/controllers/latest_news.dart';
import 'package:news_app/features/home/controllers/news_headlines.dart';
import 'package:news_app/features/home/views/widgets/latest_news_list.dart';
import 'package:news_app/features/home/views/widgets/headline_slider.dart';
import 'package:news_app/utils/theme.dart';
import 'package:news_app/widgets/app_navigation_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headlineNews = ref.watch(newsHeadlineProvider);
    final latestNews = ref.watch(latestNewsProvider);
    final latestNewsNotifier = ref.read(latestNewsProvider.notifier);
    final headlineNewsNotifier = ref.read(newsHeadlineProvider.notifier);

    // Fetch initial data when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (latestNews.isEmpty) {
        latestNewsNotifier.fetchNextPage();
      }
      if(headlineNews.isEmpty){
        headlineNewsNotifier.fetchHeadlines();
      }
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            await headlineNewsNotifier.seedFresh();
            await latestNewsNotifier.fetchLatestNews();
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent) {
                latestNewsNotifier.fetchNextPage();

              }
              return false;
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  _buildLogo(context),
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, 'Headlines'),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.maxFinite,
                    child: headlineNews.isNotEmpty ?
                    HeadlineSlider(headlines: headlineNews) :
                    Center(
                        child: CircularProgressIndicator(color: Theme.of(context).primaryColor)
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, 'Latest news'),
                  const SizedBox(height: 10),
                  Expanded(
                    child:latestNews.isEmpty
                      ? Center(
                        child: CircularProgressIndicator(color: Theme.of(context).primaryColor)
                      )
                      : ListView.builder(
                      itemCount: latestNews.length,
                      itemBuilder: (context, index) {
                        if (index == latestNews.length - 1) {
                          return Column(
                            children: [
                              LatestNewsList(news: [latestNews[index]]),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: CircularProgressIndicator(color:  Theme.of(context).primaryColor),
                              ),
                            ],
                          );
                        }
                        return LatestNewsList(news: [latestNews[index]]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const AppNavigationBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Simple', style: NewsTheme.logoTitleOne),
            Text('News', style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
        Container(
          height: 2,
          width: 50,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

