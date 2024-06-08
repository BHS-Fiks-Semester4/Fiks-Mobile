import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // Import package http
import 'dart:convert'; // Import package json convert
import 'package:mobile/view/kategori.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key); // Koreksi sintaks penulisan key

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> kategoriBarang = []; // Variabel untuk menyimpan data kategori barang

  // Fungsi untuk mengambil data kategori barang dari API
  Future<void> fetchKategoriBarang() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/kategori'));
    if (response.statusCode == 200) {
      setState(() {
        kategoriBarang = json.decode(response.body)['kategoris'];
      });
    } else {
      throw Exception('Failed to load kategori barang');
    }
  }

  @override
  void initState() {
    fetchKategoriBarang(); // Panggil fungsi fetchKategoriBarang saat widget diinisialisasi
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
              Container(
                margin: EdgeInsets.fromLTRB(34, 0, 34, 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Penjualan Terlaris',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24, 0, 15, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x40000000),
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(12, 8, 13, 7.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 7.5),
                            child: Text(
                              'MOUSE GAMING HP M100',
                              style: GoogleFonts.getFont(
                                'Inria Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.3,
                                color: Color(0xFF8B8E99),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: RichText(
                              text: TextSpan(
                                text: 'Stok: 4 | ',
                                style: GoogleFonts.getFont(
                                  'Inria Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  height: 1.3,
                                  color: Color(0xFF8B8E99),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'MOUSE',
                                    style: GoogleFonts.getFont(
                                      'Inria Sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0.5),
                        child: SizedBox(
                          width: 104.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 13, 7.5, 0),
                                child: SizedBox(
                                  width: 78.8,
                                  child: Text(
                                    'Rp. 85.000',
                                    style: GoogleFonts.getFont(
                                      'Inria Sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      height: 1.3,
                                      color: Color(0xFF8B8E99),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                        'assets/images/chevron_right.png',
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget _buildCard(BuildContext context, String title, IconData icon, int id) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailKategori(id: id), // Tambahkan halaman detail kategori
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
