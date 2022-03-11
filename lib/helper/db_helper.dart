import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskapp/constants.dart';
import 'package:taskapp/models/taskModel.dart';

class DataBaseHelper
{
  static final DataBaseHelper  _db =DataBaseHelper._();
  static Database _database;
  factory DataBaseHelper()
  {
    return _db;
  }

  DataBaseHelper._();


  Future<Database> get database async {

    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }
 initDB()async
  {
    Directory dir =await getApplicationDocumentsDirectory();
    String path =dir.path+ 'Tasks';
    final tasksList =await openDatabase(path,version: 1,onCreate: _onCreate);
    return tasksList;
  }



  void _onCreate(Database db, int version)
  async{
   await db.execute(
     'CREATE TABLE $tableName'
         '($cid INTEGER PRIMARY KEY AUTOINCREMENT,'
         '$ctitle TEXT,'
         '$cdate TEXT,'
         '$cdesc TEXT,'
         '$cpiority TEXT,'
         '$cstatus TEXT)'
   );
  }
  Future<void>insertTask(Task task)
  async{
     Database db =await database;
     await db.insert(tableName, task.toJson()
     ,conflictAlgorithm: ConflictAlgorithm.replace);
       }
  Future<int>updateTask(Task task)async
  {
    Database db=await database;
return  await db.update(tableName,task.toJson(),where :'$cid = ?',whereArgs: [task.id]);

  }
  Future<void>deleteTask(Task task)async
  {
    Database db=await database;
    await db.delete(tableName,where :'$cid = ?',whereArgs: [task.id]);
  }
  Future<List<Task>>getAllTasks() async
  {
Database db =await database;
List<Map> maps= await db.query(tableName);
return maps.isNotEmpty?maps.map((e) => Task.fromJson(e)).toList():[];

  }
}