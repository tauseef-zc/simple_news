import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/services/theme_manager.dart';
import 'package:news_app/widgets/app_navigation_bar.dart';
import 'package:news_app/widgets/custom_safe_area.dart';
import 'package:news_app/widgets/page_title.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    return CustomSafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageTitle(title: "Settings"),
              const SizedBox(height: 20),
              const Text(
                'Select Theme Color',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Colors.primaries.map((color) {
                    return GestureDetector(
                      onTap: () {
                        themeNotifier.updateThemeColor(color);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: themeState.themeColor == color
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Theme Mode',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildModeButton(
                    label: 'System',
                    icon: Icons.settings,
                    isSelected: themeState.themeMode == ThemeMode.system,
                    onTap: () {
                      themeNotifier.updateThemeMode(ThemeMode.system);
                    },
                  ),
                  _buildModeButton(
                    label: 'Light',
                    icon: Icons.light_mode,
                    isSelected: themeState.themeMode == ThemeMode.light,
                    onTap: () {
                      themeNotifier.updateThemeMode(ThemeMode.light);
                    },
                  ),
                  _buildModeButton(
                    label: 'Dark',
                    icon: Icons.dark_mode,
                    isSelected: themeState.themeMode == ThemeMode.dark,
                    onTap: () {
                      themeNotifier.updateThemeMode(ThemeMode.dark);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: const AppNavigationBar(currentIndex: 4),
      ),
    );
  }

  Widget _buildModeButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.grey,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey.shade200,
        elevation: isSelected ? 5 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
