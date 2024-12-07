import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/explore/controllers/search_controller.dart';
import 'package:news_app/features/explore/views/widgets/explore_section.dart';
import 'package:news_app/features/home/models/news.dart';
import 'package:news_app/features/home/views/widgets/latest_news_list.dart';
import 'package:news_app/utils/debouncer.dart';
import 'package:news_app/widgets/app_navigation_bar.dart';
import 'package:news_app/widgets/custom_safe_area.dart';
import 'package:news_app/widgets/page_title.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  bool showSearch = false;
  String sortBy = "publishedAt";
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final debouncer = Debouncer(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchNewsProvider);
    final searchNotifier = ref.read(searchNewsProvider.notifier);

    controller.value = TextEditingValue(text: searchNotifier.term);

    return CustomSafeArea(
      child: Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent && showSearch) {
              searchNotifier.searchNextPage();
            }
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                const PageTitle(title: "Explore"),
                const SizedBox(height: 10),
                _buildSearchBar(searchNotifier),
                const SizedBox(height: 16),
                searchNotifier.showSearch ?
                _buildSearchResults(searchResults, searchNotifier) :
                const ExploreSection(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const AppNavigationBar(currentIndex: 2),
      ),
    );
  }

  Widget _buildSearchBar(SearchNewsController searchNotifier) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      onChanged: (value) async {
        debouncer.run(() {
          searchNotifier.setSearchTerm(value);
        });
        if (value.isEmpty) {
          FocusScope.of(context).unfocus();
          searchNotifier.setHideShowSearch();
          searchNotifier.resetData();
        }
      },
      onTap: () async => searchNotifier.setShowSearch(),
      onTapOutside: (event) async {
        FocusScope.of(context).unfocus();
        if (searchNotifier.term.isEmpty) searchNotifier.setHideShowSearch();
      },
      decoration: InputDecoration(
        hintText: 'Search',
        suffixIcon: searchNotifier.term.isEmpty
            ? const Icon(Icons.search)
            : InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            searchNotifier.resetData();
            searchNotifier.setHideShowSearch();
            searchNotifier.setSearchEmpty();
            controller.clear();
          },
          child: const Icon(Icons.close_rounded),
        ),
        border: _buildInputBorder(),
        enabledBorder: _buildInputBorder(),
        focusedBorder: _buildInputBorder(width: 2.0),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }

  OutlineInputBorder _buildInputBorder({double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey.shade300, width: width),
    );
  }

  Widget _buildSearchResults(List<News> searchResults, SearchNewsController searchNotifier) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: [
                  const Text('Showing results for '),
                  Text(searchNotifier.term, style: const TextStyle(fontWeight: FontWeight.w600))
                ],
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  showMenu(
                    context: context,
                    color: Colors.white,
                    position: const RelativeRect.fromLTRB(100, 120, 0, 0),
                    menuPadding: const EdgeInsets.all(5.00),
                    items: [
                      const PopupMenuItem(
                        enabled: false,
                        child: Text('Sort by:'),

                      ),
                      PopupMenuItem(
                        value: 'publishedAt',
                        child: _buildMenuItem(selected: sortBy.contains('publishedAt'), value: 'Published At'),
                      ),
                      PopupMenuItem(
                        value: 'relevancy',
                        child: _buildMenuItem(selected: sortBy.contains('relevancy'), value: 'Relevance'),
                      ),
                      PopupMenuItem(
                        value: 'popularity',
                        child: _buildMenuItem(selected: sortBy.contains('popularity'), value: 'Popularity'),
                      ),
                    ],
                  ).then((value) async {
                    if (value != null) {
                      setState(() {
                        sortBy = value;
                      });
                      await searchNotifier.setSortBy(value);
                    }
                  });
                },
              )
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: searchNotifier.isLoading
                ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
                : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    LatestNewsList(news: [searchResults[index]]),
                    if (index == searchResults.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildMenuItem({required String value, required bool selected}) {
    return Text(value, style: TextStyle(
        fontWeight: selected ? FontWeight.w600 : FontWeight.w400
    ));
  }
}
