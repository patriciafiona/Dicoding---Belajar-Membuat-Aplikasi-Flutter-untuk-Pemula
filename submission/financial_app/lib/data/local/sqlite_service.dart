import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/Finance.dart';

class SqliteService{
  static const String databaseName = "my_finance_database.db";
  static Database? db;

  static Future<Database> initializeDB() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return db?? await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await createTables(db);
        });
  }

  static Future<void> createTables(Database database) async{
    await database.execute("""CREATE TABLE IF NOT EXISTS Finance (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount DOUBLE NOT NULL,
        category String NOT NULL,
        dateTime String NOT NULL,
        description TEXT NOT NULL
      )      
      """);
  }

  static Future<int> insertToDatabase(Finance finance) async {
    final db = await SqliteService.initializeDB();

    final id = await db.insert('Finance', finance.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Read all data
  static Future<List<Finance>> getItems() async {
    final db = await SqliteService.initializeDB();

    final List<Map<String, Object?>> queryResult = await db.query('Finance');
    return queryResult.map((e) => Finance.fromMap(e)).toList();
  }
}