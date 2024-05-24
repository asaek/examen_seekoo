import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.init();

  static Database? _database;

  DatabaseHelper.init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const userTable = '''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        username TEXT,
        email TEXT,
        phone TEXT,
        website TEXT,
        street TEXT,
        suite TEXT,
        city TEXT,
        zipcode TEXT,
        lat TEXT,
        lng TEXT,
        company_name TEXT,
        company_catchPhrase TEXT,
        company_bs TEXT
      )
    ''';

    const taskTable = '''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,
        userId INTEGER,
        title TEXT,
        completed INTEGER,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''';

    await db.execute(userTable);
    await db.execute(taskTable);
  }

  Future<void> borrarDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');

    if (await databaseExists(path)) {
      await deleteDatabase(path);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
