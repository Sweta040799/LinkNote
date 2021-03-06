import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:linkopedia/tododatabase/model.dart';

class DatabaseHelper{
    static DatabaseHelper? _databaseHelper;
    static Database? _database;

    String todoTable = 'todo_table';
    String colId = 'id';
    String colTitle = 'title';
    String colDescription = 'description';
    String colDate = 'date';

    DatabaseHelper._createInstance();

    factory DatabaseHelper() {


      if (_databaseHelper == null) {
        _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
      }
      return (_databaseHelper)!;
    }

    Future<Database?> get database async {


      if (_database == null) {
        _database = await initializeDatabase();
      }
      return _database;
    }

    Future<Database> initializeDatabase() async {
      // Get the directory path for both Android and iOS to store database.
      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path + 'task.db';


      // Open/create the database at a given path
      var todosDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
      return todosDatabase;
    }

    void _createDb(Database db, int newVersion) async {


      await db.execute('CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
          '$colDescription TEXT, $colDate TEXT)');
    }

    // Fetch Operation: Get all todo objects from database
    Future<List<Map<String, dynamic>>> getTodoMapList() async {
      Database? db = await this.database;


      //		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
      var result = await db!.query(todoTable, orderBy: '$colTitle ASC');
      return result;
    }


    // Insert Operation: Insert a Task object to database
    Future<int> insertTodo(Task tasky) async {
      Database? db = await this.database;
      var result = await db!.insert(todoTable, tasky.toMap());
      return result;
    }


    // Update Operation: Update a Task object and save it to database
    Future<int> updateTodo(Task taski) async {
      var db = await this.database;
      var result = await db!.update(todoTable, taski.toMap(), where: '$colId = ?', whereArgs: [taski.id]);
      return result;
    }




    // Delete Operation: Delete a todo object from database
    Future<int> deleteTodo(int id) async {
      var db = await this.database;
      int result = await db!.rawDelete('DELETE FROM $todoTable WHERE $colId = $id');
      return result;
    }


    // Get number of todo objects in database
    Future<int> getCount() async {
      Database? db = await this.database;
      List<Map<String, dynamic>> x = await db!.rawQuery('SELECT COUNT (*) from $todoTable');
      int? result = Sqflite.firstIntValue(x);
      return result!;
    }


    // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
    Future<List<Task>> getTodoList() async {


      var todoMapList = await getTodoMapList(); // Get 'Map List' from database
      int count = todoMapList.length;         // Count the number of map entries in db table


      List<Task> todoList = <Task>[];
      // For loop to create a 'todo List' from a 'Map List'
      for (int i = 0; i < count; i++) {
        todoList.add(Task.fromMapObject(todoMapList[i]));
      }


      return todoList;
    }
}