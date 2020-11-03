//Database related operations

//Packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future database() async {
    ///Stores db location of both android and
    ///ios dir location to be join with the db string
    final databasePath = await getDatabasesPath();

    return openDatabase(
      //Joins both db path string and notes db string together
      join(databasePath, 'notes_database.db'),
      onCreate: (database, version) {
        //SQL command storing id as int and primary key and rest of notes properties
        return database.execute(
            'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT, imagePath TEXT)');
      },
      version: 1,
    );
  }

  //Create db instance and query db in descending order
  static Future<List<Map<String, dynamic>>> getNotesFromDB() async {
    final database = await DatabaseHelper.database();
    //ID is in datetime so it cna be sorted in descending order of dates
    //final return is a list of map values
    return database.query('notes', orderBy: 'id DESC');
  }

  //Method takes in map data and sends it into the notes db
  static Future insertNoteToDB(Map<String, Object> data) async {
    //create a instance of the db
    final database = await DatabaseHelper.database();

    //insert the data into db and conflicAlg handles data 'id' that
    //conflicts which will then update instead
    int inserted = await database.insert('notes', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Method removes note from the db
  static Future deleteNoteFromDB(int id) async {
    //creates instance of the db
    final database = await DatabaseHelper.database();

    //delete data from the db using the id argument provided
    return database.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
