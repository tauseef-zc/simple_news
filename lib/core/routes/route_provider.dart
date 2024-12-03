

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routes/routes.dart';
import 'package:news_app/features/categories/views/screens/categories_screen.dart';
import 'package:news_app/features/home/views/screens/home_screen.dart';

final routeProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          name: homeRoute,
          builder: (context, state) => const HomeScreen()),
      GoRoute(
          path: '/category',
          name: categoryRoute,
          builder: (context, state) => const CategoryScreen()),
    ],
  );
});