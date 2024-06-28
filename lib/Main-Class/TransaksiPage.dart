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
import 'package:mobile/Main-Class/Struk.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tanggal dan ID Transaksi
                    Column(
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
                    SizedBox(height: 16),
                    // Form untuk Nama Customer
                    TextFormField(

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
                    SizedBox(height: 16),
                    // Detail Pesanan
                    Text(
                      'DETAIL PESANAN',
                      style: GoogleFonts.getFont(
                        'Inria Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        height: 1.3,
                        color: Color(0xFF8B8E99),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Tabel Detail Barang
                    Table(
                      border: TableBorder.all(color: Colors.grey),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.grey[
                                200], // Warna latar belakang untuk header tabel
                          ),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Nama Barang',
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
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Total Quantity',
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
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Harga',
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
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '', // Spacer for buttons
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (var barang in widget.keranjang.toSet())
                          TableRow(
                            decoration: BoxDecoration(
                              color: widget.keranjang.indexOf(barang) % 2 == 0
                                  ? Colors.white
                                  : Colors.grey[
                                      100], // Warna latar belakang bergantian untuk baris tabel
                            ),
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    barang.namaBarang,
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
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          // Tambahkan logika untuk mengurangi quantity barang
                                          if (widget.barangQtyMap[barang]! >
                                              0) {
                                            setState(() {
                                              widget.barangQtyMap[barang] =
                                                  widget.barangQtyMap[barang]! -
                                                      1;
                                            });
                                          }
                                        },
                                      ),
                                      Text(
                                        '${widget.barangQtyMap[barang]}',
                                        style: GoogleFonts.getFont(
                                          'Inria Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          height: 1.3,
                                          color: Color(0xFF8B8E99),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          // Tambahkan logika untuk menambah quantity barang
                                          setState(() {
                                            widget.barangQtyMap[barang] =
                                                widget.barangQtyMap[barang]! +
                                                    1;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Rp. ${(barang.hargaSetelahDiskonBarang * widget.barangQtyMap[barang]!).toStringAsFixed(2)}',
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
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      // Tambahkan logika untuk menghapus barang dari keranjang
                                      setState(() {
                                        widget.keranjang.remove(barang);
                                        widget.barangQtyMap.remove(barang);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),


                    SizedBox(height: 16),
                    // Jumlah Bayar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jumlah Bayar',
                          style: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            height: 1.3,
                            color: Color(0xFF8B8E99),
                          ),
                        ),
                        TextFormField(
                          controller: _bayarController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Masukkan jumlah bayar',
                            hintStyle: GoogleFonts.getFont(
                              'Inria Sans',
                              fontWeight: FontWeight.w700,
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
                      ],
                    ),
                    SizedBox(height: 16),
                    // Kembalian
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kembalian',
                          style: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            height: 1.3,
                            color: Color(0xFF8B8E99),
                          ),
                        ),
                        Text(
                          'Rp. ${_bayarController.text.isNotEmpty ? (double.tryParse(_bayarController.text) ?? 0) - totalHarga : 0}',
                          style: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            height: 1.3,
                            color: Color(0xFF8B8E99),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Tombol Submit
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          double kembalian =
                              double.parse(_bayarController.text) - totalHarga;

                          List<Map<String, dynamic>> detailTransaksi =
                              widget.keranjang.map((barang) {
                            return {
                              'id_barang': barang.id,
                              'qty': widget.barangQtyMap[barang]!,
                              'sub_total':
                                  widget.hargaSetelahDiskonBarang[barang]!,
                            };
                          }).toList();

                          final response = await http.post(
                            Uri.parse('http://127.0.0.1:8000/api/transaksi'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode({
                              'id_karyawan': widget.currentUser.id.toString(),
                              'total_harga': totalHarga.toString(),
                              'bayar': _bayarController.text,
                              'kembalian': kembalian.toString(),
                     
                              'detail_transaksi': detailTransaksi,
                            }),
                          );

                          if (response.statusCode == 200 ||
                              response.statusCode == 201) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Berhasil melakukan transaksi'),
                              ),
                            );
                            // Navigate to StrukPage after successful transaction
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StrukPage(
                                  transactionId:
                                      '12345', // Replace with actual transaction ID
                                 
                                  formattedDate: DateFormat('yyyy-MM-dd HH:mm')
                                      .format(DateTime.now()),
                                  totalHarga: totalHarga,
                                  bayar: double.parse(_bayarController.text),
                                  kembalian: kembalian,
                                  barangQtyMap: widget.barangQtyMap,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Gagal melakukan transaksi error: ${response.statusCode}'),
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFFD006B)),
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFFD006B),
                        ),
                        child: Center(
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
          ),
        ),
      ),
    );
  }
}
