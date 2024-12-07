import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/routes/route_provider.dart';
import 'package:news_app/app/services/theme_manager.dart';
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
    final themeState = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'SimpleNews',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: NewsTheme.lightTheme.copyWith(
        primaryColor: themeState.themeColor,
        chipTheme: ChipThemeData(
          shape: StadiumBorder(
            side: BorderSide(color: themeState.themeColor.shade100),
          ),
          backgroundColor: themeState.themeColor.shade50,
          surfaceTintColor: themeState.themeColor.shade100,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: themeState.themeColor.shade500)
      ),
      darkTheme: NewsTheme.darkTheme.copyWith(
        primaryColor: themeState.themeColor,
      ),
      themeMode: themeState.themeMode,
    );
  }
}
