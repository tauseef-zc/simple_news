import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/app/routes/routes.dart';
import 'package:news_app/features/categories/views/screens/categories_screen.dart';
import 'package:news_app/features/categories/views/screens/category_news.dart';
import 'package:news_app/features/explore/views/screens/explore_screen.dart';
import 'package:news_app/features/explore/views/screens/news_detail_screen.dart';
import 'package:news_app/features/favourites/views/screens/favourite_screen.dart';
import 'package:news_app/features/home/models/news.dart';
import 'package:news_app/features/home/views/screens/home_screen.dart';
import 'package:news_app/features/settings/settings_screen.dart';

final routeProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          name: homeRoute,
          pageBuilder: (context, state) => _buildPageWithAnimation(state, const HomeScreen(), _fadeTransition)
      ),
      GoRoute(
          path: '/category',
          name: categoryRoute,
          pageBuilder: (context, state) => _buildPageWithAnimation(state, const CategoryScreen(), _fadeTransition)
      ),
      GoRoute(
          path: '/category/:category',
          name: categoryNewsRoute,
          pageBuilder: (context, state) {
          final category = state.pathParameters['category'] ?? 'general';
          return _buildPageWithAnimation(state, CategoryNewsScreen(category: category), _fadeTransition);
        },
      ),
      GoRoute(
        path: '/explore',
        name: exploreRoute,
        pageBuilder: (context, state) =>_buildPageWithAnimation(state, const ExploreScreen(), _fadeTransition),
      ),
      GoRoute(
        path: '/favourites',
        name: favouriteRoute,
        pageBuilder: (context, state) =>_buildPageWithAnimation(state, const FavoriteNewsScreen(), _fadeTransition),
      ),
      GoRoute(
        path: '/news-detail',
        name: singleNewsRoute,
        pageBuilder: (context, state) {
          final news = state.extra as News;
          return _buildPageWithAnimation(state, NewsDetailScreen(news), _fadeTransition);
        },
      ),
      GoRoute(
        path: '/settings',
        name: settingsRoute,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(state, const SettingsScreen(), _fadeTransition);
        },
      ),
    ],
  );
});

Page<dynamic> _buildPageWithAnimation(
    GoRouterState state, Widget child, Widget Function(BuildContext, Animation<double>, Animation<double>, Widget) transitionsBuilder) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: transitionsBuilder,
  );
}

Widget _fadeTransition(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}