import 'package:flutter/material.dart';
import 'package:mobile/view/editprofile.dart';
import 'package:mobile/models/login_response/user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:mobile/view/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  final User user;

  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User _currentUser = User();

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final loggedInUserId = await DatabaseHelper().getLoggedInUserId();
    if (loggedInUserId != null) {
      final user = await DatabaseHelper().getUser(loggedInUserId);
      if (user != null) {
        setState(() {
          _currentUser = user;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    // CircleAvatar(
                    //   radius: 60,
                    //   backgroundImage: _currentUser.foto != null && _currentUser.foto!.isNotEmpty
                    //       ? MemoryImage(base64Decode(_currentUser.foto!)!)
                    //       : AssetImage('assets/logo.png'),
                    // ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0,
                              0), // Ganti dengan warna border yang diinginkan
                          width:
                              3, // Ganti dengan ketebalan border yang diinginkan
                        ),
                      ),
                      child: ClipOval(
                        child: Image.memory(
                          base64Decode(_currentUser.foto.toString()),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image, size: 100);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 7, 0, 9),
                child: Text(
                  '${_currentUser.name}',
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              buildTextField('Username', _currentUser.username),
              SizedBox(height: 15),
              buildTextField('Alamat', _currentUser.alamat),
              SizedBox(height: 20),
              buildTextField('Tanggal Lahir', _currentUser.tanggalLahir),
              SizedBox(height: 20),
              buildTextField('Agama', _currentUser.agama),
              SizedBox(height: 20),
              buildTextField('Email', _currentUser.email),
              SizedBox(height: 20),
              buildTextField('No Hp', _currentUser.noHp),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final updatedUser = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditProfile(currentUser: _currentUser),
                    ),
                  );
                  if (updatedUser != null) {
                    setState(() {
                      _currentUser = updatedUser;
                    });
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(420, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text('Edit Profile'),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String? value) {
    IconData? iconData;

    // Tentukan ikon berdasarkan label teks
    switch (labelText) {
      case 'Username':
        iconData = Icons.person;
        break;
      case 'Alamat':
        iconData = Icons.home;
        break;
      case 'Tanggal Lahir':
        iconData = Icons.calendar_today;
        break;
      case 'Agama':
        iconData = Icons.star;
        break;
      case 'Email':
        iconData = Icons.email;
        break;
      case 'No Hp':
        iconData = Icons.phone;
        break;
      default:
        iconData = null;
    }

    // Kembalikan widget TextFormField dengan konfigurasi dekorasi dan nilai
    return Container(
      width: 430,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: TextField(
        controller: TextEditingController(text: value),
        style: TextStyle(fontSize: 16, color: Colors.black),
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          prefixIcon:
              iconData != null ? Icon(iconData) : null, // Tambahkan ikon
          labelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
