import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mobile/models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'akhwat_computer2.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user(
            id INTEGER PRIMARY KEY,
            username TEXT,
            email TEXT,
            password TEXT,
            alamat TEXT,
            agama TEXT,
            tanggal_lahir TEXT,
            no_hp TEXT
          )
        ''');
      },
      version: 1,
    );
  }

 Future<int> addUser(User user) async {
  Database db = await database;
  return await db.insert('user', user.toJson());
}

Future<User?> getUserByUsername(String username) async {
  Database db = await database;
  List<Map<String, dynamic>> maps = await db.query(
    'user',
    where: 'username = ?', // Menggunakan kondisi WHERE berdasarkan username
    whereArgs: [username],
  );
  if (maps.isNotEmpty) {
    return User.fromJson(maps.first);
  } else {
    return null;
  }
}

Future<int> updateUserByUsername(User user) async {
  Database db = await database;
  return await db.update(
    'user',
    user.toJson(),
    where: 'username = ?', // Menggunakan kondisi WHERE berdasarkan username
    whereArgs: [user.username],
  );
}

Future<int> deleteUserByUsername(String username) async {
  Database db = await database;
  return await db.delete(
    'user',
    where: 'username = ?', // Menggunakan kondisi WHERE berdasarkan username
    whereArgs: [username],
  );
}

}
