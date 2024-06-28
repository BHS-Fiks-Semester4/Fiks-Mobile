import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Tambahkan ini untuk format tanggal
import 'package:mobile/main.dart';
import 'package:mobile/models/DataBarang.dart';
import 'package:mobile/models/DataTransaksi.dart';
import 'package:mobile/models/Keranjang.dart'; // Sesuaikan dengan path proyek Anda
import 'package:http/http.dart' as http;
import 'package:mobile/view/BarangTransaksi.dart';
import 'dart:convert';
import 'package:provider/provider.dart'; // Import provider

import 'package:mobile/models/login_response/user.dart';

class TransaksiPage extends StatefulWidget {
  final List<Barang> keranjang;
  final double totalHarga;
  final int qty;
  final int jumlahBarang;
  final Map<Barang, int> barangQtyMap;
  final Map<Barang, double> hargaSetelahDiskonBarang;
  final User currentUser; // Assuming User is the type of your currentUser
  final int id;


  const TransaksiPage({
    Key? key,
    required this.keranjang,
    required this.totalHarga,
    required this.qty,
    required this.jumlahBarang,
    required this.barangQtyMap, // Tambahkan barangQtyMap di sini
    required this.currentUser,
    required this.hargaSetelahDiskonBarang,
    required this.id,
  }) : super(key: key);

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaCustomerController = TextEditingController();
  final _bayarController = TextEditingController();
  User currentUser = User();



  String generateTransactionId() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMddHHmmss').format(now);
    return 'TRX$formattedDate';
  }

  @override
  void initState() {
    super.initState();
    currentUser = widget.currentUser;
  }

  @override
  void dispose() {
    _namaCustomerController.dispose();
    _bayarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung total harga berdasarkan jumlah barang
    double totalHarga = 0;
    widget.barangQtyMap.forEach((barang, qty) {
      totalHarga += (barang.hargaSetelahDiskonBarang ?? 0) * qty;
      // 'Rp. ${((barang.hargaSetelahDiskonBarang ?? 0) * qty).toStringAsFixed(2)}',
    });
    

    String transactionId = generateTransactionId();
    String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Tanggal dan ID Transaksi
              Container(
                margin: EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanggal: $formattedDate',
                      style: GoogleFonts.getFont(
                        'Inria Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        height: 1.3,
                        color: Color(0xFF8B8E99),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ID Transaksi: $transactionId',
                      style: GoogleFonts.getFont(
                        'Inria Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        height: 1.3,
                        color: Color(0xFF8B8E99),
                      ),
                    ),
                  ],
                ),
              ),
              // Form untuk Nama Customer
              Container(
                margin: EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: TextFormField(
                  controller: _namaCustomerController,
                  decoration: InputDecoration(
                    labelText: 'Nama Customer',
                    labelStyle: TextStyle(
                      color: Color(0xFF8B8E99),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Customer tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              // Detail Pesanan
              Container(
                margin: EdgeInsets.fromLTRB(24, 0, 24, 8.5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'DETAIL PESANAN',
                    style: GoogleFonts.getFont(
                      'Inria Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      height: 1.3,
                      color: Color(0xFF8B8E99),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24, 0, 24, 8.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nama Barang',
                      style: GoogleFonts.getFont(
                        'Inria Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        height: 1.3,
                        color: Color(0xFF8B8E99),
                      ),
                    ),
                    Text(
                      'Total Quantity',
                      style: GoogleFonts.getFont(
                        'Inria Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        height: 1.3,
                        color: Color(0xFF8B8E99),
                      ),
                    ),
                    Text(
                      'Harga',
                      style: GoogleFonts.getFont(
                        'Inria Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        height: 1.3,
                        color: Color(0xFF8B8E99),
                      ),
                    ),
                  ],
                ),
              ),
              // List Barang
              for (var barang in widget.keranjang.toSet())
                Container(
                  margin: EdgeInsets.fromLTRB(24, 0, 24, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        barang.namaBarang,
                        style: GoogleFonts.getFont(
                          'Inria Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          height: 1.3,
                          color: Color(0xFF8B8E99),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // Kurangi jumlah barang
                              setState(() {
                                if (widget.barangQtyMap[barang]! > 1) {
                                  widget.barangQtyMap[barang] =
                                      widget.barangQtyMap[barang]! - 1;
                                }
                              });
                            },
                            child: Icon(Icons.remove),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${widget.barangQtyMap[barang]}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Color(0xFF8B8E99),
                            ),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              // Tambah jumlah barang jika masih ada stok tersedia
                              setState(() {
                                if (widget.barangQtyMap[barang]! <
                                    barang.stokBarang) {
                                  widget.barangQtyMap[barang] =
                                      widget.barangQtyMap[barang]! + 1;
                                } else {
                                  // Jika stok habis, tampilkan notifikasi
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Stok ${barang.namaBarang} habis'),
                                    ),
                                  );
                                }
                              });
                            },
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                      Text(
                        'Rp. ${((barang.hargaSetelahDiskonBarang ?? 0) * widget.barangQtyMap[barang]!).toStringAsFixed(2)}',
                        style: GoogleFonts.getFont(
                          'Inria Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          height: 1.3,
                          color: Color(0xFF8B8E99),
                        ),
                      ),
                    ],
                  ),
                ),

              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 27, 12.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 2.5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Total Harga',
                          style: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 8,
                            height: 1.3,
                            color: Color(0xFF8B8E99),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Rp. ${totalHarga.toStringAsFixed(2)}',
                        style: GoogleFonts.getFont(
                          'Inria Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          height: 1.3,
                          color: Color(0xFF8B8E99),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 27, 12.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 2.5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Jumlah Bayar',
                          style: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 8,
                            height: 1.3,
                            color: Color(0xFF8B8E99),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        controller: _bayarController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Masukkan jumlah bayar',
                          hintStyle: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            height: 1.3,
                            color: Color(0xFF8B8E99),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Jumlah bayar tidak boleh kosong';
                          } else if (double.tryParse(value) == null) {
                            return 'Jumlah bayar harus berupa angka';
                          } else if (double.parse(value) < totalHarga) {
                            return 'Jumlah bayar tidak boleh kurang dari total harga';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Kembalian
              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 27, 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 2.5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Kembalian',
                          style: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 8,
                            height: 1.3,
                            color: Color(0xFF8B8E99),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Rp. ${_bayarController.text.isNotEmpty ? (double.tryParse(_bayarController.text) ?? 0) - totalHarga : 0}',
                        style: GoogleFonts.getFont(
                          'Inria Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          height: 1.3,
                          color: Color(0xFF8B8E99),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Tombol Submit
              Container(
                margin: EdgeInsets.fromLTRB(26, 0, 26, 190),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFD006B)),
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFFD006B),
                ),
                child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      Keranjang transaksi = Keranjang(
                        id: transactionId, // Menggunakan ID transaksi yang dihasilkan
                        idKaryawan:
                            'KRY123', // Sesuaikan dengan ID karyawan yang diinginkan
                        totalHarga: totalHarga,
                        qty: widget.keranjang
                            .length, // Menghitung jumlah barang dalam keranjang
                        bayar: double.parse(_bayarController.text),
                        kembalian:
                            double.parse(_bayarController.text) - totalHarga,
                      );

                      // Implementasi penyimpanan ke database di sini menggunakan nilai transaksi
                      print(transaksi.toMap());
                      
                      double kembalian =
                      double.parse(_bayarController.text) - totalHarga;

                      List<Map<String, dynamic>> detailTransaksi = widget.keranjang.map((barang) {
      return {
        'id_barang': barang.id,
        'qty': widget.barangQtyMap[barang]!,
        'sub_total': widget.hargaSetelahDiskonBarang[barang]!,
      };
    }).toList();

                      final response = await http.post(
                        Uri.parse('http://127.0.0.1:8000/api/transaksi'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode({
                          'id_karyawan': currentUser.id
                              .toString(), // Assuming currentUser.id is correctly defined
                          'total_harga': totalHarga
                              .toString(), // Assuming totalHarga is correctly defined
                          'bayar': _bayarController
                              .text, // Assuming _bayarController is correctly defined
                          'kembalian': kembalian
                              .toString(), // Assuming kembalian is correctly defined
                          'detail_transaksi': detailTransaksi, // Correctly passing the list of maps without type annotation
                        }),
                      );
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Berhasil melakukan transaksi')),
                        );
                        // Navigasi ke halaman LoginPage setelah berhasil melakukan transaksi
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Gagal melakukan transaksi error: ${response.statusCode}')),
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 3.5, 0, 2.5),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.getFont(
                        'Inria Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.3,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}