import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modal/bookModal.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper databaseHelper = DatabaseHelper._();

  factory DatabaseHelper() => databaseHelper;
  Database? db;

  Future<Database> get database async => db ?? await iniData();

  Future<Database> iniData() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'Book.db');

    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE Book(id INTEGER PRIMARY KEY,
                Title TEXT,
                Author TEXT,
                Status TEXT
                )''';
        await db.execute(sql);
      },
    );
    return db!;
  }

  Future<void> insertDta(BookModal book) async {
    Database db = await database;
    await db.insert('Book', book.toMap());
  }

  Future<List<BookModal>> getData({String? query}) async {
    Database db = await database;
    final List maps;

    if (query != null && query.isNotEmpty) {
      maps = await db
          .query('Book', where: 'Title LIKE ?', whereArgs: ['%$query%']);
    } else {
      maps = await db.query('Book');
    }
    return List.generate(
      maps.length,
      (index) {
        // String Title;
        //   String Author;
        //   String Status;
        return BookModal(
            id: maps[index]['id'].toString(),
            Author: maps[index]['Author'],
            Status: maps[index]['Status'],
            Title: maps[index]['Title']);
      },
    );
  }

  Future<int> updateContact(BookModal book) async {
    Database db = await database;
    return await db.update(
      'Book',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<void> deleteDetail(int id) async {
    Database? db = await database;
    await db.delete('Book', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<BookModal>> selectData(String? query) async {
    Database db = await database;
    final List maps;
    if (query != null && query.isNotEmpty) {
      maps = await db
          .query('Book', where: 'Status Like ?', whereArgs: ['%$query%']);
    } else {
      maps = await db.query('Book');
    }
    return List.generate(maps.length, (index) {
      return BookModal(
          id: maps[index]['id'].toString(),
          Author: maps[index]['Author'],
          Status: maps[index]['Status'],
          Title: maps[index]['Title']);
    });
  }
}
