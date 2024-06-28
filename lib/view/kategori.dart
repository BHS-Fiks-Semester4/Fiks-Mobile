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
                  return GestureDetector(
                    onTap: () {
                      _showBarangDetailDialog(context, barang);
                    },
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                                      // 'Rp. ${barang.hargaSetelahDiskonBarang.toStringAsFixed(2)}',
                                      'Rp. ${((barang.hargaSetelahDiskonBarang ?? 0)).toStringAsFixed(2)}',
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
                    ),
                  );
                },
              );
            } else {
              return Center(
                  child: Text('Tidak ada data barang untuk kategori ini'));
            }
          }
        },
      ),
    );
  }

  void _showBarangDetailDialog(BuildContext context, Barang barang) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${barang.namaBarang}'),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar di tengah
              Expanded(
                flex: 2,
                child: Image.memory(
                  base64Decode(barang.fotoBarang),
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image, size: 150);
                  },
                ),
              ),
              SizedBox(width: 16), // Spasi antara gambar dan teks
              // Teks di sebelah kiri
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Spesifikasi'),
                    Text('>   ${barang.deskripsiBarang}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Harga'),
                    Text('>   ${barang.hargaSetelahDiskonBarang}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Garansi'),
                    Text('>   ${barang.garansiBarang}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Stok'),
                    Text('>   ${barang.stokBarang}'),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  Future<List<Barang>> fetchData(int id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/barang/$id'));
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body)['barangs'];
      return responseData.map((e) => Barang.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data barang');
    }
  }
}
