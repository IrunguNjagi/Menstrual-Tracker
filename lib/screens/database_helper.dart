import 'package:period_tracker/screens/data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*This particular class contains code of the database helper, where tables are defined and
corresponding code outlined
*/
class DatabaseHelper {
  static Database _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'data.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Data(id INTEGER PRIMARY KEY AUTOINCREMENT, data TEXT)');
      },
    );
  }

  Future<int> insertData(DataModel data) async {
    final db = await database;
    return await db.insert('Data', data.toMap());
  }

  Future<List<DataModel>> getData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Data');

    return List.generate(maps.length, (i) {
      return DataModel(
        id: maps[i]['id'],
        data: maps[i]['data'],
      );
    });
  }

  Future<void> updateData(DataModel data) async {
    final db = await database;
    await db.update(
      'Data',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  Future<void> deleteData(int id) async {
    final db = await database;
    await db.delete(
      'Data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
