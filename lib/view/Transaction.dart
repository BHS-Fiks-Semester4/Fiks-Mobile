import 'package:flutter/material.dart';
import 'package:mobile/models/DataBarang.dart';
import 'package:mobile/view/BarangTransaksi.dart';
import 'package:mobile/Main-Class/Service.dart';
import 'package:http/http.dart' as http;

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List<Barang> _listBarang = [];

  Future<void> fetchBarang() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/data_barang'));

    if (response.statusCode == 200) {
      setState(() {
        _listBarang = Barang.parseBarangs(response.body);
      });
    } else {
      throw Exception('Failed to load barangs');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Transaction',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20), // Add some spacing between text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BarangTransaksi(listBarang: _listBarang)),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Change button color
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15)), // Change button padding
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Change border radius
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag,
                          size: 80, color: Colors.pink), // Change icon color
                      SizedBox(height: 10), // Add some spacing between icon and text
                      Text('PENJUALAN',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black)), // Change button label size and color
                    ],
                  ),
                ),
                SizedBox(width: 20), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Service()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Change button color
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15)), // Change button padding
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Change border radius
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.build,
                          size: 80, color: Colors.pink), // Change icon color
                      SizedBox(height: 10), // Add some spacing between icon and text
                      Text('SERVICE',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black)), // Change button label size and color
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
