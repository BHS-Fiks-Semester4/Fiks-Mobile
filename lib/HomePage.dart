import 'package:flutter/material.dart';
import 'package:mobile/view/Profile.dart';
import 'package:mobile/view/Transaction.dart';
import 'package:mobile/view/Management.dart';
import 'package:mobile/view/Report.dart';
import 'package:mobile/view/Home.dart';
import 'package:mobile/models/user.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getBody(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade300,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage, color: Colors.black),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, color: Colors.black),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart, color: Colors.black),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return Home();
      case 1:
        return Management();
      case 2:
        return Transaction();
      case 3:
        return Report();
      case 4:
        return Profile(user: widget.user);
      default:
        return Home();
    }
  }
}
