import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/categories/entity/category_item.dart';
import 'package:news_app/features/categories/views/widgets/category_card.dart';
import 'package:news_app/widgets/app_navigation_bar.dart';
import 'package:news_app/widgets/page_title.dart';

class CategoryScreen extends ConsumerWidget {
  static final List<CategoryItem> categories = [
    const CategoryItem('General', 'assets/icons/general.svg'),
    const CategoryItem('Business', 'assets/icons/business.svg'),
    const CategoryItem('Sports', 'assets/icons/sport.svg'),
    const CategoryItem('Health', 'assets/icons/health.svg'),
    const CategoryItem('Entertainment', 'assets/icons/entertainment.svg'),
    const CategoryItem('Technology', 'assets/icons/technology.svg'),
    const CategoryItem('Science', 'assets/icons/science.svg'),
  ];

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const PageTitle(title: 'Categories'),
            const Text('You can find news from different categories here.',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                )),
            const SizedBox(height: 20),
            Expanded(
                child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) =>
                  CategoryCard(category: categories[index]),
            ))
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 1),
    ));
  }
}
