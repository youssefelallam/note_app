import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'Note.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT,
    "note" TEXT,
    "color" TEXT
  )
 ''');

    await batch.commit();
  }

  deleting_db() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'Note.db');
    await deleteDatabase(path);
  }
}
