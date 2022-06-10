import 'package:intl/intl.dart';

import 'activity_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  // creating the getter the database
  Future<Database> get database async {
    // first let's check that we don't already have a db

    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), "life_app.db"),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE activity (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          days INT,
          target INT,
          creationDate DATE,
          lastUpdated TEXT
        )
        ''');
        // make sure that the names are similar to our model variables
      },
      version: 10,
    );
  }

  // Function that will add a new note to our variable
  addNewActivity(ActivityModel activity) async {
    final db = await database;
    db.insert("activity", activity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Function that will fetch our database and return all elements in notes table
  Future<dynamic> getActivities() async {
    final db = await database;
    var res = await db.query("activity");
    if (res.isEmpty) {
      return Null;
    } else {
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }

  // Function to delete a note
  Future<int> deleteActivity(int id) async {
    final db = await database;
    int count = await db.rawDelete("DELETE FROM activity WHERE id = ?", [id]);
    return count; // return the number of row deleted
  }

  Future<int> updateActivityDay(int id, int days) async {
    final db = await database;
    int count =
        await db.rawDelete("UPDATE activity SET days = $days WHERE id = $id");
    return count; // return the number of row deleted
  }

  updateLastUpdated(int id) async {
    var today = DateTime.now();
    String todayString = DateFormat('d').format(today);
    final db = await database;
    await db.execute(
        "UPDATE activity SET lastUpdated = $todayString WHERE id = $id");
  }
}
