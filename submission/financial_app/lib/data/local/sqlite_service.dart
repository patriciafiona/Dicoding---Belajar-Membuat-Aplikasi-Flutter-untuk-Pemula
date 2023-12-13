import 'package:financial_app/data/local/model/User.dart';
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

    await database.execute("""CREATE TABLE IF NOT EXISTS User (
        name String PRIMARY KEY NOT NULL,
        joinDate String NOT NULL,
        cardNumber String NOT NULL,
        avatarString String NOT NULL
      )      
      """);
  }

  static Future<int> insertFinanceToDatabase(Finance finance) async {
    final db = await SqliteService.initializeDB();

    final id = await db.insert('Finance', finance.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertUserToDatabase(User user) async {
    final db = await SqliteService.initializeDB();

    final id = await db.insert('User', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<bool> isUserCreated() async {
    final db = await SqliteService.initializeDB();

    final List<Map<String, Object?>> queryResult = await db.query('User');
    if(queryResult.map((e) => User.fromMap(e)).toList().isEmpty){
      return false;
    }else{
      return true;
    };
  }

  static Future<User> getUser() async {
    final db = await SqliteService.initializeDB();

    final List<Map<String, Object?>> queryResult = await db.query('User');
    return queryResult.map((e) => User.fromMap(e)).toList().first;
  }

  static Future<void> updateUserData(User user) async {
    final db = await SqliteService.initializeDB();

    await db.update(
      'User',
      user.toMap(),
      where: 'cardNumber = ?',
      whereArgs: [user.cardNumber],
    );
  }

  static Future<List<Finance>> getFinanceItems() async {
    final db = await SqliteService.initializeDB();

    final List<Map<String, Object?>> queryResult = await db.query('Finance');
    return queryResult.map((e) => Finance.fromMap(e)).toList();
  }

  static Future<List<Finance>> getLastThreeTransactionItems() async {
    final db = await SqliteService.initializeDB();

    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      "SELECT * from Finance ORDER BY dateTime DESC LIMIT 3"
    );
    return queryResult.map((e) => Finance.fromMap(e)).toList();
  }
}