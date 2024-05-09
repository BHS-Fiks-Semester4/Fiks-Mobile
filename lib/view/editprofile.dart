import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:mobile/models/login_response/user.dart';
import 'DatabaseHelper.dart';

class EditProfile extends StatefulWidget {
  final User currentUser;

  const EditProfile({Key? key, required this.currentUser}) : super(key: key);

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _alamatController;
  late TextEditingController _agamaController;
  late TextEditingController _tanggalLahirController;
  late TextEditingController _noHpController;

  final _databaseHelper = DatabaseHelper(); // Kelas untuk mengelola database SQFlite

  @override
  void initState() {
    super.initState();
    _usernameController =
        TextEditingController(text: widget.currentUser.username);
    _emailController = TextEditingController(text: widget.currentUser.email);
    _alamatController = TextEditingController(text: widget.currentUser.alamat);
    _agamaController = TextEditingController(text: widget.currentUser.agama);
    _tanggalLahirController =
        TextEditingController(text: widget.currentUser.tanggalLahir);
    _noHpController = TextEditingController(text: widget.currentUser.noHp);
  }

  @override
  void dispose() {
    // Membersihkan controller ketika widget dihapus
    _usernameController.dispose();
    _emailController.dispose();
    _alamatController.dispose();
    _agamaController.dispose();
    _tanggalLahirController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _alamatController,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _agamaController,
              decoration: InputDecoration(labelText: 'Agama'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _tanggalLahirController,
              decoration: InputDecoration(labelText: 'Tanggal Lahir'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _noHpController,
              decoration: InputDecoration(labelText: 'No HP'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Menyiapkan data pengguna yang akan diperbarui
                final updatedUser = User(
                  id: widget.currentUser.id,
                  username: _usernameController.text,
                  email: _emailController.text,
                  alamat: _alamatController.text,
                  agama: _agamaController.text,
                  tanggalLahir: _tanggalLahirController.text,
                  noHp: _noHpController.text,
                );
                
                // Memperbarui data pengguna di database
                await _databaseHelper.updateProfile(updatedUser);

                // Kembali ke halaman sebelumnya
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
