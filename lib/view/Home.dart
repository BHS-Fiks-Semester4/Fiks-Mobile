import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile/view/kategori.dart';
import 'package:mobile/models/pengeluaran.dart';
import 'package:mobile/models/transaksi.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> kategoriBarang = [];
  List<Transaksi> transaksiList = [];
  List<Pengeluaran> pengeluaranList = [];
  String selectedButton = '';
  String selectedMonth =
      DateTime.now().month.toString(); // Track selected month
  Future<void> fetchKategoriBarang() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/kategori'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'success') {
        kategoriBarang = data['kategoris'];
      } else {
        throw Exception('Failed to load kategori');
      }
    } else {
      throw Exception('Failed to load kategori');
    }
  }

  Map<String, dynamic> fetchedData = {};
  // List<Transaksi> transaksiList = [];
  // List<Pengeluaran> pengeluaranList = [];

  Future<void> fetchTransactionsForMonth(String month) async {
    String baseUrl = 'http://127.0.0.1:8000/api/transaksi/';
    String fullUrl = baseUrl + month;
    Uri url = Uri.parse(fullUrl);

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final transaksiJson = data['transaksi'] as List;
        final pengeluaranJson = data['pengeluaran'] as List;

        setState(() {
          transaksiList =
              transaksiJson.map((json) => Transaksi.fromJson(json)).toList();
          pengeluaranList = pengeluaranJson
              .map((json) => Pengeluaran.fromJson(json))
              .toList();
          selectedButton = month; // Set selected button here
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void loadCurrentMonthTransactions() {
    String currentMonth = DateTime.now().month.toString();
    fetchTransactionsForMonth(currentMonth);
  }

  @override
  void initState() {
    fetchKategoriBarang();
    loadCurrentMonthTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFD006B),
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 35, 15, 55),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 26),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 11, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      borderRadius: BorderRadius.circular(23),
                                    ),
                                    child: Container(
                                      width: 46,
                                      height: 46,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 7, 0, 9),
                                  child: Text(
                                    'WELCOME ...M HILFAN PERDANA',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              width: 330,
                              height: 164,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(34, 0, 34, 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Kategori Barang',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var kategori in kategoriBarang)
                      _buildCard(
                        context,
                        kategori['nama_jenis_barang'],
                        kategori['foto'],
                        kategori['id'],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 1; i <= 12; i++)
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            selectedMonth =
                                i.toString(); // Update selected month on hover
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            selectedMonth = DateTime.now()
                                .month
                                .toString(); // Reset selected month on exit hover
                          });
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            fetchTransactionsForMonth(
                                i.toString()); // Fetch data for each month
                          },
                          child: Text(getMonthName(i)),
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.5),
                              width: 1,
                            ),
                          ).copyWith(
                            backgroundColor: MaterialStateProperty.all(
                              selectedButton == i.toString()
                                  ? const Color.fromRGBO(253, 0, 107, 1)
                                  : Colors.white,
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              selectedButton == i.toString()
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: transaksiList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("Transaksi"),
                      trailing: Text(
                        "+ ${transaksiList[index].totalHarga.toString()}",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: pengeluaranList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("Pengeluaran"),
                      trailing: Text(
                        "- ${pengeluaranList[index].totalPengeluaran.toString()}",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, String fotoBase64, int id) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailKategori(id: id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mengonversi base64 ke Image widget
            Image.memory(
              base64Decode(fotoBase64),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String getMonthName(int monthNumber) {
    List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[monthNumber - 1];
  }

// Class untuk Halaman Detail Kategori

  void main() {
    runApp(MaterialApp(
      home: Home(),
    ));
  }
}
