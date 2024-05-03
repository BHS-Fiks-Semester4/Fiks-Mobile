import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/view/editprofile.dart';
import 'package:mobile/models/loginrespon.dart';

class Profile extends StatefulWidget {
  final Loginrespon user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                          widget.user.name??'',
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
              Container(
                width: 430,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  controller:
                      TextEditingController(text: '${widget.user.username}'),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    prefix: Icon(Icons.person),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 430,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  controller:
                      TextEditingController(text: '${widget.user.alamat}'),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Alamat',
                    prefix: Icon(Icons.location_city),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 430,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  controller: TextEditingController(
                      text: '${widget.user.tanggalLahir}'),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tanggal Lahir',
                    prefix: Icon(Icons.person),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 430,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  controller:
                      TextEditingController(text: '${widget.user.agama}'),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Agama',
                    prefix: Icon(Icons.person),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 430,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  controller:
                      TextEditingController(text: '${widget.user.email}'),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefix: Icon(Icons.person),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                width: 430,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  controller:
                      TextEditingController(text: '${widget.user.noHp}'),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'No Hp',
                    prefix: Icon(Icons.person),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 10),
               ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(currentUser: widget.user),
                  ),
                );
              },
              child: Text('Edit Profile'),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
