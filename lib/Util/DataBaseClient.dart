import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unfound/Model/SavedNewsModel.dart';

class DataBaseHelper {
  static final DataBaseHelper _instance = DataBaseHelper.internal();

  factory DataBaseHelper() => _instance;

  //News Table variable
  final String tableNews = "SavedNewsTable";
  final String NewsIdcol = "NewsId";
  final String NewsTitleCol = "NewsTitle";
  final String NewsImageUrlCol = "NewsImageUrl";
  final String NewsUrlCol = "NewsUrl";

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  DataBaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "SavedNews.db");
    var ourDb = await openDatabase(path, version: 2, onCreate: _onConfigure);
    return ourDb;
  }

  void _onConfigure(Database db, int version) async {

    //News Table
    await db.execute("""
    CREATE TABLE $tableNews(
    $NewsIdcol INTEGER PRIMARY KEY AUTOINCREMENT,
    $NewsTitleCol TEXT,
    $NewsImageUrlCol TEXT,
    $NewsUrlCol TEXT)
    """
    );
  }

  // Insertion into HeadUnit
  Future<int> saveNewsItem(SavedNewsModel item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableNews", item.toMap());
    return res;
  }

  //Get News data
  Future<List> getItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableNews");
    print("DataBase Table \n $result");
    return result.toList();
  }

  //Call this method if Item is deleted from News
  Future<int> deleteNewsItems(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableNews, where: "$NewsIdcol = ?", whereArgs: [id]);
  }

}