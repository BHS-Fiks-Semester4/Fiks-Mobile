import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // Import package http
import 'dart:convert'; // Import package json convert
import 'package:mobile/view/kategori.dart';
import 'package:mobile/models/pengeluaran.dart';
import 'package:mobile/models/transaksi.dart';
import 'package:mobile/models/detailTransaksi.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key); // Koreksi sintaks penulisan key

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> kategoriBarang =
      []; // Variabel untuk menyimpan data kategori barang

  // Fungsi untuk mengambil data kategori barang dari API
  Future<void> fetchKategoriBarang() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/kategori'));
    if (response.statusCode == 200) {
      setState(() {
        kategoriBarang = json.decode(response.body)['kategoris'];
      });
    } else {
      throw Exception('Failed to load kategori barang');
    }
  }

  Map<String, dynamic> fetchedData = {};
  List<Transaksi> transaksiList = [];
  List<Pengeluaran> pengeluaranList = [];
  List<DetailTransaksi> detailTransaksiList = [];

  Future<void> fetchTransactionsForMonth(String month) async {
    String baseUrl = 'http://127.0.0.1:8000/api/transaksi/';
    String fullUrl = baseUrl +
        month.toString(); // Convert 'month' to a string before concatenating
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
        });
      } else {
        // Handle errors
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
void loadCurrentMonthTransactions() {
  DateTime now = DateTime.now();
  String currentMonth = now.month.toString();
  fetchTransactionsForMonth(currentMonth); // Memanggil fungsi yang sudah ada dengan bulan saat ini
}
  @override
  void initState() {
    fetchKategoriBarang();
  loadCurrentMonthTransactions(); // Memuat transaksi bulan saat ini

     // Panggil fungsi fetchKategoriBarang saat widget diinisialisasi
    super.initState();
    
  }
bool isHoveringMaret = false;
bool isHoveringApril = false;
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
                      // Menggunakan data kategoriBarang untuk membuat card
                      for (var kategori in kategoriBarang)
                        _buildCard(
                          context,
                          kategori['nama_jenis_barang'],
                          Icons.category, // Atur icon sesuai kebutuhan
                          kategori['id'], // Atur widget sesuai kebutuhan
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('1'); // Fetch data for January
                            },
                            child: Text('Januari'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('2'); // Fetch data for February
                            },
                            child: Text('Februari'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('3'); // Fetch data for March
                            },
                            child: Text('Maret'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('4'); // Fetch data for April
                            },
                            child: Text('April'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('5'); // Fetch data for May
                            },
                            child: Text('Mei'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('6'); // Fetch data for June
                            },
                            child: Text('Juni'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('7'); // Fetch data for July
                            },
                            child: Text('Juli'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('8'); // Fetch data for August
                            },
                            child: Text('Agustus'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('9'); // Fetch data for September
                            },
                            child: Text('September'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('10'); // Fetch data for October
                            },
                            child: Text('Oktober'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('11'); // Fetch data for November
                            },
                            child: Text('November'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              fetchTransactionsForMonth('12'); // Fetch data for December
                            },
                            child: Text('Desember'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey.withOpacity(0.2),
                              ),
                              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue; // Change the color when hovered
                                  }
                                  return Colors.black; // Default color
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Add more TextButtons for other months
                    ],
                  ),
                ),
                  
             
            
                ListView.builder(
                  shrinkWrap:
                      true, // Use it to make ListView work inside Column
                  physics:
                      NeverScrollableScrollPhysics(), // Disables scrolling within the ListView
                  itemCount:
                      transaksiList.length, // Number of items in your list
                  itemBuilder: (context, index) {
                    // Assuming Transaksi has a title or similar property to display
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text("Transaksi"),
                        trailing: Text(
                          "+ ${transaksiList[index].totalHarga.toString()}",
                          style: TextStyle(
                            color: Colors
                                .green, // Optional: Makes the text green to indicate a positive value
                          ),
                        ),
                        // You can add more details from Transaksi here
                      ),
                    );
                  },
                ),
                
                ListView.builder(
                  shrinkWrap:
                      true, // Use it to make ListView work inside Column
                  physics:
                      NeverScrollableScrollPhysics(), // Disables scrolling within the ListView
                  itemCount:
                      pengeluaranList.length, // Number of items in your list
                  itemBuilder: (context, index) {
                    // Assuming Pengeluaran has a title or similar property to display
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text("Pengeluaran"),
                        trailing: Text(
                          "- ${pengeluaranList[index].totalPengeluaran.toString()}",
                          style: TextStyle(
                            color: Colors
                                .red, // Optional: Makes the text red to indicate a negative value
                          ),
                        ),
                        // You can add more details from Pengeluaran here
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, int id) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailKategori(id: id), // Tambahkan halaman detail kategori
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
            // Ganti ikon default dengan ikon kustom
            Image.asset(
              'assets/logo.png', // Lokasi gambar ikon kustom
              width: 50,
              height: 50,
              color: Colors.blue, // Atur warna ikon kustom jika diperlukan
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
}

// Class untuk Halaman Detail Kategori

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}
