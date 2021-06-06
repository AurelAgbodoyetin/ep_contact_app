import 'package:ep_contacts_app/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteHelper {
  Database? db;
  final String tName = "epContact";

  Future<void> open() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'epFlutter.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table epContact ( 
          id integer primary key autoincrement, 
          name text not null,
          email text not null,
          phone text not null,
          desc text,
          sex integer not null,
          isFavorite integer not null
          )
      ''');
    });
  }

  Future<Contact> insert(Contact contact) async {
    await open();
    contact.id = await db?.insert(tName, contact.toMap());
    await close();
    return contact;
  }

  Future<Contact?> getContact(int id) async {
    await open();
    List<Map<String, dynamic>?>? maps = await db?.query(
      tName,
      where: 'id = ?',
      whereArgs: [id],
    );
    await close();

    int l = maps?.length ?? 0;

    if (l > 0) {
      return Contact.fromMap(maps?.first);
    }
    return null;
  }

  Future<List<Contact>?> getAllContact() async {
    await open();
    List<Map<String, dynamic>?>? maps = await db?.query(tName);
    await close();
    return maps?.map((contactMap) => Contact.fromMap(contactMap)).toList();
  }

  Future<List<Contact>?> getFavorites() async {
    await open();
    List<Map<String, dynamic>?>? maps = await db?.query(
      tName,
      where: "isFavorite = ?",
      whereArgs: [1],
    );
    await close();
    return maps?.map((contactMap) => Contact.fromMap(contactMap)).toList();
  }

  Future<int?> delete(int id) async {
    await open();
    int? a = await db?.delete(tName, where: 'id = ?', whereArgs: [id]);
    await close();
    return a;
  }

  Future<int?> update(Contact contact) async {
    await open();
    int? a = await db?.update(
      tName,
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
    return a;
  }

  Future<void> close() async => db?.close();
}
