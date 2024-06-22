import 'package:mobile/models/Keranjang.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mobile/models/DataTransaksi.dart';
import 'package:mobile/models/login_response/user.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    sqfliteFfiInit(); // Inisialisasi sqflite ffi
    databaseFactory = databaseFactoryFfi; // Mengatur factory database
    return await openDatabase(
      join(await getDatabasesPath(), 'akhwat_computer2.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS users("
          "id INTEGER PRIMARY KEY, "
          "name TEXT, "
          "email TEXT, "
          "alamat TEXT, "
          "username TEXT, "
          "no_hp TEXT, "
          "agama TEXT, "
          "tanggal_lahir TEXT, "
          "foto BLOB, " // Change to BLOB for storing image data
          "isLoggedIn INTEGER DEFAULT 0"
          ")",
        );

        await db.execute(
          "CREATE TABLE IF NOT EXISTS transaksi("
          "id INTEGER PRIMARY KEY, "
          "user_id INTEGER, "
          "total INTEGER, "
          "date TEXT"
          ")",
        );

        // Add other table creation if needed
      },
      version: 1,
    );
  }

  Future<User?> getUser(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (maps.isNotEmpty) {
        return User.fromMap(maps.first);
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengambil data user dari database: $e');
    }
    return null;
  }

  Future<int?> getLoggedInUserId() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'isLoggedIn = ?',
        whereArgs: [1],
        limit: 1,
      );
      if (maps.isNotEmpty) {
        return maps.first['id'] as int;
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengambil ID user yang login: $e');
    }
    return null;
  }

  Future<void> insertUser(User user) async {
    try {
      final db = await database;
      await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Data user berhasil disimpan ke database.');
    } catch (e) {
      print('Terjadi kesalahan saat menyimpan data user ke database: $e');
    }
  }

  Future<void> updateProfile(User user) async {
    try {
      final db = await database;
      await db.update(
        'users',
        user.toMap(),
        where: "id = ?",
        whereArgs: [user.id],
      );
      print('Data user berhasil diperbarui di database.');
    } catch (e) {
      print('Terjadi kesalahan saat memperbarui data user di database: $e');
    }
  }

  Future<void> simpanTransaksi(Keranjang transaksi) async {
    try {
      final db = await database;
      await db.insert(
        'transaksi',
        transaksi.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Data transaksi berhasil disimpan ke database.');
    } catch (e) {
      print('Terjadi kesalahan saat menyimpan data transaksi ke database: $e');
    }
  }
}
