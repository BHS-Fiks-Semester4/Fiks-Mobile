import 'package:flutter/material.dart';
import 'package:mobile/view/editprofile.dart';
import 'package:mobile/models/login_response/user.dart';

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
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                          'assets/poto.png'), // Ganti dengan path gambar Anda
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentUser.name ?? '',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
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
                            borderRadius: BorderRadius.circular(10)))),
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
