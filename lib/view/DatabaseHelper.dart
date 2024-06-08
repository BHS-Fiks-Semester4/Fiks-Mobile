import 'package:mobile/models/Keranjang.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mobile/models/DataTransaksi.dart';
import 'package:mobile/models/login_response/user.dart';

class DatabaseHelper {
  late Database _database;

  Future<Database> get database async {
    await _initDatabase(); // Memastikan inisialisasi database sebelum digunakan
    return _database;
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'akhwat_computer2.db'),
      onCreate: (db, version) {
        // Membuat tabel user jika belum ada
        db.execute(
          "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, alamat TEXT, username TEXT, no_hp TEXT, agama TEXT, tanggal_lahir TEXT)",
        );

        // Membuat tabel transaksi jika belum ada
      },
      version: 1,
    );
  }

  Future<int?> getLoggedInUserId() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'isLoggedIn = ?', // Asumsi ada kolom isLoggedIn
        whereArgs: [1], // Asumsi 1 untuk true
        limit: 1, // Karena hanya memerlukan satu user yang login
      );
      if (maps.isNotEmpty) {
        // Asumsi kolom ID adalah 'id'
        return maps.first['id'] as int;
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengambil ID user yang login: $e');
    }
    return null; // Kembalikan null jika tidak ada user yang login atau terjadi kesalahan
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
