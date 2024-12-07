import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/database/db_manager.dart';
import 'package:news_app/features/home/models/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dbProvider = Provider<DBManager>((ref) {
  return DBManager.defaultDatabase();
});

class FavoriteNewsNotifier extends StateNotifier<List<News>> {
  final DBManager dbManager;

  FavoriteNewsNotifier(this.dbManager) : super([]);

  Future<void> cacheFavourites() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    List<Map<String, dynamic>> titles =  await dbManager.query('SELECT title FROM news');
    await prefs.setStringList('favourites', titles.map<String>((e) => e['title'] as String).toList() ?? []);
  }

  Future<void> loadFavorites() async {
    final result = await dbManager.query('SELECT * FROM news');
    state = result.map((map) => News.fromMap(map)).toList();
  }

  Future<bool> addFavorite(News news) async {

    await dbManager.insert('news', news.toMap());
    await loadFavorites();
    await cacheFavourites();
    return true;
  }

  Future<bool> deleteFavorite(String title) async {
    await dbManager.delete('news', 'title', title);
    await loadFavorites();
    await cacheFavourites();
    return true;
  }
}

final favoriteNewsProvider =
StateNotifierProvider<FavoriteNewsNotifier, List<News>>((ref) {
  final dbManager = ref.read(dbProvider);
  return FavoriteNewsNotifier(dbManager)..loadFavorites();
});