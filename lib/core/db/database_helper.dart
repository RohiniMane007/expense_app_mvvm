import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// import '../domain/models/expense_models.dart';

class DatabaseHelper {
  final _dbName = 'expenseDatabase';

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _dbName);

    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create the table
        await db.execute('''CREATE TABLE expenses (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          date TEXT,
          category TEXT,
          amount TEXT,
          description TEXT
        )
      ''');

        await db.execute('''CREATE TABLE user (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT,
          email TEXT,
          phone_no TEXT,
          username TEXT,
          password TEXT
        )
      ''');
      },
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
