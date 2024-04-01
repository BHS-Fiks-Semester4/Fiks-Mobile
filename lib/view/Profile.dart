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
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Username: ${widget.user.username}',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                'Nama Lengkap: ${widget.user.name}',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                'Alamat: ${widget.user.alamat}',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}