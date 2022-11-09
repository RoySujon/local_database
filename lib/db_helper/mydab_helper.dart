import 'package:local_database/model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//CREATE DATABASE WITH PATH
class MyDBHelper {
  static Future<Database> initDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'contact.db');
    return await openDatabase(path, onCreate: _onCreate);
  }

//FOR CREATE TABLE WITH QUARY
  static Future _onCreate(Database db, int version) async {
    final sql =
        '''CREATE TABLE contact_tbl (int INTEGER PRIMARY KEY,name Text,phone Text)''';
    await db.execute(sql);
  }

//FOR INSERT DATA
  static Future<int> createContact(Contact contact) async {
    Database db = await MyDBHelper.initDB();
    return await db.insert('contact_tbl', contact.toMap());
  }

//FOR UPDATE DATA
  static Future<int> updateContact(Contact contact) async {
    Database db = await MyDBHelper.initDB();
    // var contact = await db.query('contact_tbl');
    return await db.update('contact_tbl', contact.toMap(),
        where: 'id =?', whereArgs: [contact.id]);
  }

//FOR DELETE DATA
  static Future<int> deleteContact(int id) async {
    Database db = await MyDBHelper.initDB();

    return await db.delete('contact_tbl', where: 'id =?', whereArgs: [id]);
  }

//FOR DISPLAY CONTACT DATA
  static Future<List<Contact>> readContact() async {
    Database db = await MyDBHelper.initDB();
    var contact = await db.query('contact_tbl');
    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((e) => Contact.fromMap(e)).toList()
        : [];
    return contactList;
  }
}
