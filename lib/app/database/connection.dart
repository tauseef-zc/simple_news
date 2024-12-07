import 'package:news_app/app/database/migrations.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  static const databaseName = "news_app";
  static final DatabaseConnection _instance = DatabaseConnection._internal();
  static Database? _database;

  factory DatabaseConnection() {
    return _instance;
  }

  DatabaseConnection._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(Tables.noteTables);
    });
  }
}