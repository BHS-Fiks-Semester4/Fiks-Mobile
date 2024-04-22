import 'package:flutter/material.dart';
import 'package:mobile/model.dart';

class Profile extends StatefulWidget {
  final User user;
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
                      TextEditingController(text: '${widget.user.name}'),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(Icons.people),
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
            ],
          ),
        ),
      ),
    );
  }
}
