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
                      builder: (context) => EditProfile(currentUser: _currentUser),
                    ),
                  );
                  if (updatedUser != null) {
                    setState(() {
                      _currentUser = updatedUser;
                    });
                  }
                },
                child: Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String? value) {
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
          prefix: Icon(Icons.person),
          labelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
