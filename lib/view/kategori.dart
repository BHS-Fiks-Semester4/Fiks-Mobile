import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile/models/DataBarang.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/models/Kategori.dart';

class DetailKategori extends StatelessWidget {
  final int id;

  const DetailKategori({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kategori'),
      ),
      body: FutureBuilder(
        future: fetchData(id),
        builder: (context, AsyncSnapshot<List<Barang>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Barang>? dataBarang = snapshot.data;
            if (dataBarang != null && dataBarang.isNotEmpty) {
              return ListView.builder(
                itemCount: dataBarang.length,
                itemBuilder: (context, index) {
                  final barang = dataBarang[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Menampilkan gambar barang dari base64 string
                              Image.memory(
                                base64Decode(barang.fotoBarang),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.image, size: 50);
                                },
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    barang.namaBarang,
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Rp. ${barang.hargaSetelahDiskonBarang.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Stok: ${barang.stokBarang}',
                                    style: GoogleFonts.getFont(
                                      'Inria Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.3,
                                      color: Color(0xFF8B8E99),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('Tidak ada data barang untuk kategori ini'));
            }
          }
        },
      ),
    );
  }

  // Method untuk mengambil data barang dari API berdasarkan kategori ID
  Future<List<Barang>> fetchData(int id) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/barang/$id'));
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body)['barangs'];
      return responseData.map((e) => Barang.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data barang');
    }
  }
}
