import 'package:flutter/material.dart';
import 'package:mobile/models/login_response/user.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'dart:convert';
import 'DatabaseHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

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
  late TextEditingController _nameController;
  Uint8List? _imageBytes;
  String? _base64Image;

  final _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentUser.name);
    _usernameController =
        TextEditingController(text: widget.currentUser.username);
    _emailController = TextEditingController(text: widget.currentUser.email);
    _alamatController = TextEditingController(text: widget.currentUser.alamat);
    _agamaController = TextEditingController(text: widget.currentUser.agama);
    _tanggalLahirController =
        TextEditingController(text: widget.currentUser.tanggalLahir);
    _noHpController = TextEditingController(text: widget.currentUser.noHp);
    _base64Image = widget.currentUser.foto;
    _imageBytes = _base64Image != null ? base64Decode(_base64Image!) : null;
    
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _alamatController.dispose();
    _agamaController.dispose();
    _tanggalLahirController.dispose();
    _noHpController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _uploadImage(int userId, String base64Image) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:8000/api/users/$userId/upload-profile-image'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'foto': base64Image}),
      );

      if (response.statusCode == 200) {
        print('Profile image uploaded successfully');
      } else {
        print(
            'Failed to upload profile image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading profile image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageBytes != null
                        ? MemoryImage(_imageBytes!)
                        : AssetImage('assets/logo.png')
                            as ImageProvider,
                    child: _imageBytes == null
                        ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                        : null,
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _alamatController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _agamaController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Agama',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _tanggalLahirController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _noHpController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'No HP',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    User updatedUser = widget.currentUser.copyWith(
                      name: _nameController.text,
                      username: _usernameController.text,
                      email: _emailController.text,
                      alamat: _alamatController.text,
                      agama: _agamaController.text,
                      tanggalLahir: _tanggalLahirController.text,
                      noHp: _noHpController.text,
                      foto: _base64Image,
                    );

                    await _databaseHelper.updateProfile(updatedUser);

                    if (_base64Image != null) {
                      await _uploadImage(updatedUser.id!, _base64Image!);
                    }

                    // Add the API call to update user data here
                    final response = await http.put(
                      Uri.parse(
                          'http://127.0.0.1:8000/api/users/${updatedUser.id}'),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonEncode(updatedUser.toMap()),
                    );

                    if (response.statusCode == 200) {
                      print('User data updated successfully on the server');
                    } else {
                      print(
                          'Failed to update user data on the server. Status code: ${response.statusCode}');
                    }

                    Navigator.pop(context, updatedUser);
                  },
                  child: Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
