import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/routes/route_provider.dart';
import 'package:news_app/utils/theme.dart';

void main() {
  runApp(const ProviderScope(
    child: MainWidget(),
  ));
}

class MainWidget extends ConsumerWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routeProvider);
    return MaterialApp.router(
      title: 'SimpleNews',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: NewsTheme.lightTheme,
      darkTheme: NewsTheme.darkTheme,
    );
  }
}
