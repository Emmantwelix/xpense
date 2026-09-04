import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//SQLite connection
//singleton class to manage the database connection
class TransactionDatabase {
  TransactionDatabase._internal();
  static final TransactionDatabase instance = TransactionDatabase._internal(); //singleton instance

  static Database? _database;

  //tests set this to [inMemoryDatabasePath] so every test starts empty
  // and nothing is written to disk. Production code leaves it null.
  static String? overridePath;                

  Future<Database> get database async { //get instance
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Closes the connection and forgets it, so the next database call
  // opens fresh. Tests call this in tearDown for isolation.
  Future<void> close() async {          
    await _database?.close();
    _database = null;
  }

  Future<Database> _initDatabase() async {
    final path = overridePath ?? join(await getDatabasesPath(), 'xpense.db'); // CHANGED

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