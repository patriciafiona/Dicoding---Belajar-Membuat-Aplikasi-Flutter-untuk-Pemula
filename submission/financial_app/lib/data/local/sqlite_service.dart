import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/Finance.dart';

class SqliteService{
  static const String databaseName = "my_finance_database.db";
  static Database? db;

  static Future<Database> initizateDb() async{
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
        Id TEXT NOT NULL,
        Amount DOUBLE NOT NULL,
        Type INTEGER NOT NULL,
        Description TEXT NOT NULL,
      )      
      """);
  }

  static Future<int> createItem(Finance finance) async {
    final db = await SqliteService.initizateDb();

    final id = await db.insert('Finance', finance.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Read all data
  static Future<List<Finance>> getItems() async {
    final db = await SqliteService.initizateDb();

    final List<Map<String, Object?>> queryResult = await db.query('Finance');
    return queryResult.map((e) => Finance.fromMap(e)).toList();
  }
}