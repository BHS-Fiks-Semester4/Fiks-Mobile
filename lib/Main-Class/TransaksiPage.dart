import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/models/DataBarang.dart';
import 'package:mobile/models/DataTransaksi.dart'; // Sesuaikan dengan path proyek Anda



class TransaksiPage extends StatefulWidget {
  final List<Barang> keranjang;
  final double totalHarga;

  const TransaksiPage({
    Key? key,
    required this.keranjang,
    required this.totalHarga,
  }) : super(key: key);

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaCustomerController = TextEditingController();
  final _bayarController = TextEditingController();

  @override
  void dispose() {
    _namaCustomerController.dispose();
    _bayarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalHarga = widget.totalHarga;
    double totalQty = widget.keranjang.fold(0, (sum, item) => sum + item.jumlah);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                      'Qty',
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
              for (var barang in widget.keranjang)
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
                      Text(
                        '${barang.jumlah}x',
                        style: GoogleFonts.getFont(
                          'Inria Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          height: 1.3,
                          color: Color(0xFF8B8E99),
                        ),
                      ),
                      Text(
                        'Rp. ${barang.hargaSetelahDiskonBarang.toStringAsFixed(2)}',
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
              // Total Harga
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
              // Form untuk Jumlah Bayar
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
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      DataTransaksi transaksi = DataTransaksi(
                        id: 'TRX123', // Sesuaikan dengan ID transaksi yang diinginkan
                        idKaryawan: 'KRY123', // Sesuaikan dengan ID karyawan yang diinginkan
                        totalHarga: totalHarga,
                        qty: totalQty,
                        bayar: double.parse(_bayarController.text),
                        kembalian: (double.parse(_bayarController.text) - totalHarga),
                      );

                      // Implementasi penyimpanan ke database di sini menggunakan nilai transaksi
                      print(transaksi.toMap());
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
