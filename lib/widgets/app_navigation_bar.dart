import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/app/routes/routes.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  _AppNavigationBarState createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      switch (index) {
        case 0:
          context.replaceNamed(homeRoute);
          break;
        case 1:
          context.replaceNamed(categoryRoute);
          break;
        case 2:
          context.replaceNamed(exploreRoute);
          break;
        case 3:
          context.replaceNamed(favouriteRoute);
          break;
        case 4:
          context.replaceNamed(settingsRoute);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
    );
  }
}
