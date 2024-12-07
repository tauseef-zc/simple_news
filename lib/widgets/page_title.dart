import 'package:flutter/material.dart';
import '../utils/theme.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: NewsTheme.logoTitleOne.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 32,
            ),
            textAlign: TextAlign.left),
        const SizedBox(height: 4),
        Container(
          height: 2,
          width: 50,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox( height: 20),
      ],
    );
  }
}