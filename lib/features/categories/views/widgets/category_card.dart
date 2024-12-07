import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/app/routes/routes.dart';
import 'package:news_app/features/categories/entity/category_item.dart';
import 'package:news_app/utils/theme.dart';

class CategoryCard extends StatelessWidget {
  final CategoryItem category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          context.pushNamed(
            categoryNewsRoute,
            pathParameters: {
              'category': category.title,
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              category.iconPath,
              height: 80,
              width: 80,
              theme: SvgTheme(
                currentColor: NewsTheme.primaryColor
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}