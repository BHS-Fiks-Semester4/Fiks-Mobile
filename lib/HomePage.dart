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
import 'package:mobile/models/DataBarang.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final User homePage;

  const HomePage({Key? key, required this.homePage}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Barang> listBarang = [];
  bool isLoading = false;

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
      return Transaction();
        // return DataBarangWidget();
        // return isLoading
        //     ? CircularProgressIndicator()
        //     : DataBarangWidget(listBarang: listBarang);
      case 2:
        return Report();
      case 3:
         return Profile(user: widget.homePage);

    
       
      default:
        return Home();
    }
  }

  @override
  void initState() {
    super.initState();
    // Panggil API ketika halaman pertama kali dibuka
    _fetchDataBarang();
  }

  void _fetchDataBarang() async {
  setState(() {
    isLoading = true;
  });

  try {
    List<Barang> data = await getDataBarang();
    setState(() {
      listBarang = data;
      isLoading = false;
    });
    print('Data barang berhasil dimuat: $listBarang');
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    // Tampilkan pesan kesalahan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal memuat data barang: $e')),
    );
  }
}

}
Future<List<Barang>> getDataBarang() async {
  final url = Uri.parse('http://10.0.2.2:8000/api/data_barang');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['barangs'];
      List<Barang> barangs = [];
      data.forEach((json) {
        try {
          final barang = Barang.fromJson(json);
          barangs.add(barang);
          print('Barang: $barang');
        } catch (e) {
          print('Error parsing barang: $e');
        }
      });
      return barangs;
    } else {
      throw Exception('Gagal memuat data barang: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Gagal terhubung ke server: $e');
  }
}


