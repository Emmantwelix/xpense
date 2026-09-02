import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//SQLite connection
//singleton class to manage the database connection
class TransactionDatabase {
  TransactionDatabase._internal();
  static final TransactionDatabase instance = TransactionDatabase._internal(); //singleton instance

  static Database? _database;

  //get instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'xpense.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            description TEXT NOT NULL,
            category TEXT NOT NULL,
            date TEXT NOT NULL,
            amount REAL NOT NULL,
            type TEXT NOT NULL
          )
        ''');
      },
    );
  }
}