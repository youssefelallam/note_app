import 'package:flutter/material.dart';
import 'package:note_app/util/sqlit_manager.dart';
import 'package:sqflite/sqflite.dart';

class NoteData extends ChangeNotifier {
  SqlDb sqlDb = SqlDb();


  String NoteColor = 'red';
  changeNoteColor(String color){
    NoteColor = color;
    notifyListeners();
  }

  readData(String table) async {
    Database? mydb = await sqlDb.db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insertData(String table, Map<String, Object?> values) async {
    Database? mydb = await sqlDb.db;
    int response = await mydb!.insert(table, values);
    notifyListeners();
    return response;
  }

  updateData(String table, Map<String, Object?> value, var id) async {
    Database? mydb = await sqlDb.db;
    int response =
        await mydb!.update(table, value, where: 'id = ?', whereArgs: [id]);
    notifyListeners();
    return response;
  }

  deleteData(String table, String mywhere) async {
    Database? mydb = await sqlDb.db;
    int response = await mydb!.delete(table, where: mywhere);
    notifyListeners();

    return response;
  }

  deleteAllRow(String table) async {
    Database? mydb = await sqlDb.db;
    int response = await mydb!.delete(table);
    notifyListeners();

    return response;
  }
}
