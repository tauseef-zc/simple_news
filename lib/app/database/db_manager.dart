import 'package:news_app/app/database/connection.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  late final Future<Database> database;

  DBManager.defaultDatabase() {
    database = DatabaseConnection().database;
  }

  DBManager.testDatabase(this.database);

  Future<int> insert(String tableName, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> query(String query) async {
    final db = await database;
    return await db.rawQuery(query);
  }

  Future<int> update(String tableName, Map<String, dynamic> data, String where,
      dynamic value) async {
    final db = await database;
    return db.update(tableName, data, where: '$where=?', whereArgs: [value]);
  }

  Future<int> delete(String tableName, String where, dynamic value) async {
    final db = await database;
    return db.delete(tableName, where: '$where=?', whereArgs: [value]);
  }
}