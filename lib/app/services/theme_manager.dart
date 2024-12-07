import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState {
  final MaterialColor themeColor;
  final ThemeMode themeMode;

  ThemeState({
    required this.themeColor,
    required this.themeMode,
  });

  ThemeState copyWith({
    MaterialColor? themeColor,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      themeColor: themeColor ?? this.themeColor,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}


class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier()
      : super(
    ThemeState(
      themeColor: Colors.blue,
      themeMode: ThemeMode.system,
    ),
  ) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeColorValue = prefs.getInt('themeColor') ?? Colors.blue.value;
    final themeModeIndex = prefs.getInt('themeMode') ?? ThemeMode.system.index;

    state = state.copyWith(
      themeColor: Colors.primaries.firstWhere(
            (color) => color.value == themeColorValue,
        orElse: () => Colors.orange,
      ),
      themeMode: ThemeMode.values[themeModeIndex],
    );
  }

  Future<void> updateThemeColor(MaterialColor color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeColor', color.value);
    state = state.copyWith(themeColor: color);
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
    state = state.copyWith(themeMode: mode);
  }
}

final themeProvider =
StateNotifierProvider<ThemeNotifier, ThemeState>((ref) => ThemeNotifier());
