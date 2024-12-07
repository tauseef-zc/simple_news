import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/database/db_manager.dart';
import 'package:news_app/features/home/models/news.dart';

final dbProvider = Provider<DBManager>((ref) {
  return DBManager.defaultDatabase();
});

class FavoriteNewsNotifier extends StateNotifier<List<News>> {
  final DBManager dbManager;

  FavoriteNewsNotifier(this.dbManager) : super([]);

  Future<void> loadFavorites() async {
    final result = await dbManager.query('SELECT * FROM news');
    state = result.map((map) => News.fromMap(map)).toList();
  }

  Future<bool> addFavorite(News news) async {

    await dbManager.insert('news', news.toMap());
    await loadFavorites();
    return true;
  }

  Future<void> deleteFavorite(int id) async {
    await dbManager.delete('news', 'id', id);
    await loadFavorites();
  }
}

final favoriteNewsProvider =
StateNotifierProvider<FavoriteNewsNotifier, List<News>>((ref) {
  final dbManager = ref.read(dbProvider);
  return FavoriteNewsNotifier(dbManager)..loadFavorites();
});