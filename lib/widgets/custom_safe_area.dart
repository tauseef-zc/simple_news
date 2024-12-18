import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;

  const CustomSafeArea({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).appBarTheme.backgroundColor,
      child: SafeArea(
        child: child,
      ),
    );
  }
}