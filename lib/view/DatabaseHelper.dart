import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
        // Tidak perlu membuat tabel jika tabel sudah ada
        return db.execute(
          "CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY, name TEXT, email TEXT, alamat TEXT, username TEXT, no_hp TEXT, agama TEXT, tanggal_lahir TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> updateProfile(User user) async {
    try{
    final db = await database;
    await db.update(
      'user',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
     print('Data user berhasil diperbarui di database.');
  } catch (e) {
    print('Terjadi kesalahan saat memperbarui data user di database: $e');
  }
  }
}
