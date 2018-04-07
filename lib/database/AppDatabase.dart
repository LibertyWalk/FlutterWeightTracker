import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weight_tracker/models/Workout.dart';
import 'package:weight_tracker/models/Routine.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class AppDatabase {
  AppDatabase();
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: createDatabase);
    return theDb;
  }

  void createDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE Workouts(id STRING PRIMARY KEY, title TEXT, description TEXT)");
    await db.execute("CREATE TABLE Routines(id STRING PRIMARY KEY, title TEXT, notes TEXT, weight INTEGER, reps INTEGER)");

    print("Database was Created!");
  }

  Future<List<Workout>> getAllWorkouts() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("Workouts");
    return res.map((map) => new Workout(title: map["title"], description: map["description"], id: map["id"])).toList();
  }

  Future<List<Routine>> getAllRoutines(String workout) async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("Routines", where: "workout = ?", whereArgs: [workout]);
    return res.map((map) => new Routine(title: map["title"], description: map["description"], id: map["id"], workout: map["workout"])).toList();
  }

  Future<int> addWorkout(Workout workout) async {
    var dbClient = await db;
    int res = await dbClient.insert("Workouts", workout.toMap());
    return res;
  }

  Future<int> addRoutine(Routine routine) async {
    var dbClient = await db;
    int res = await dbClient.insert("Routines", routine.toMap());
    return res;
  }

  Future<int> updateWorkout(Workout workout) async {
    var dbClient = await db;
    int res = await dbClient.update(
      "Workouts",
      workout.toMap(),
      where: "id = ?",
      whereArgs: [workout.id]);
      return res;
  }

  Future<int> updateRoutine(Routine routine) async {
    var dbClient = await db;
    int res = await dbClient.update(
      "Routines",
      routine.toMap(),
      where: "id = ?",
      whereArgs: [routine.id]);
      return res;
  }

  Future<int> deleteWorkout(String id) async {
    var dbClient = await db;
    var res = await dbClient.delete(
      "Workouts",
      where: "id = ?",
      whereArgs: [id]);
      print("Deleted workout with ID: " + id);
      return res;
  }

  Future<int> deleteRoutine(String id) async {
    var dbClient = await db;
    var res = await dbClient.delete(
      "Routines",
      where: "id = ?",
      whereArgs: [id]);
      print("Deleted workout with ID: " + id);
      return res;
  }

  Future<int> clearWorkouts() async {
    var dbClient = await db;
    var res = await dbClient.execute("DELETE from Workouts");
      print("Deleted workout table contents");
      return res;
  }

  Future<int> clearRoutines() async {
    var dbClient = await db;
    var res = await dbClient.execute("DELETE from Routines");
      print("Deleted routine table contents");
      return res;
  }
}