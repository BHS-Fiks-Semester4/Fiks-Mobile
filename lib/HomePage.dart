import 'package:flutter/material.dart';
import 'package:mobile/models/login_response/login_response.dart';
import 'package:mobile/view/Profile.dart';
import 'package:mobile/view/Transaction.dart';
import 'package:mobile/view/Management.dart';
import 'package:mobile/view/Report.dart';
import 'package:mobile/view/Home.dart';
import 'package:mobile/models/login_response/user.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mobile/main.dart';

class HomePage extends StatefulWidget {
  final User homePage;

  const HomePage({Key? key, required this.homePage}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getBody(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        color: Color.fromRGBO(253, 0, 107, 1),
        buttonBackgroundColor: Color.fromRGBO(253, 0, 107, 1),
        height: 50,
        animationDuration: Duration(milliseconds: 200),
        index: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.data_usage, size: 30, color: Colors.white),
          Icon(Icons.add_circle, size: 30, color: Colors.white),
          Icon(Icons.insert_chart, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
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
        return Profile(user: widget.homePage);
      default:
        return Home();
    }
  }
}
