import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'photo.dart';

class DBHelper {
  static Database _db;
 
  static const String TABLE = 'PhotosTable';
  static const String DB_NAME = 'photos.db';

  static const String ID = 'id';
  static const String photo = 'photo_name';
  static const String USER_NAME = 'user_name';

  Future<Database> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }



  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var  db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

    _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $photo TEXT, $USER_NAME TEXT)");
  }

  Future<Photo> save(Photo employee) async {
    print("=======employee data=======");
    _db.rawInsert("INSERT INTO $TABLE($ID, $photo,$USER_NAME) VALUES(NULL,'"+employee.photo_name+"','"+employee.user_name+"')");
    return employee;
  }

  Future<List<Photo>> getPhotos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, photo, USER_NAME]);
    print("maps get photo ===== "+"$maps");
    List<Photo> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Photo.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}