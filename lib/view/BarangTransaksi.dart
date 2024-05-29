import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/models/DataBarang.dart';
import 'package:mobile/Main-Class/TransaksiPage.dart';
import 'package:mobile/models/DataTransaksi.dart';

class BarangTransaksi extends StatefulWidget {
  final List<Barang> listBarang;

  const BarangTransaksi({Key? key, required this.listBarang}) : super(key: key);

  @override
  _BarangTransaksiState createState() => _BarangTransaksiState();
}

class _BarangTransaksiState extends State<BarangTransaksi> {
  int jumlahBarang = 0;
  double totalHarga = 0.0;
  Map<Barang, int> keranjang = {};

  void tambahBarang(Barang barang) {
    setState(() {
      if (keranjang.containsKey(barang)) {
        keranjang[barang] = keranjang[barang]! + 1;
      } else {
        keranjang[barang] = 1;
      }
      jumlahBarang++;
      totalHarga += barang.hargaSetelahDiskonBarang;
    });
  }

  void kurangiBarang(Barang barang) {
    if (jumlahBarang > 0 &&
        keranjang.containsKey(barang) &&
        keranjang[barang]! > 0) {
      setState(() {
        keranjang[barang] = keranjang[barang]! - 1;
        if (keranjang[barang] == 0) {
          keranjang.remove(barang);
        }
        jumlahBarang--;
        totalHarga -= barang.hargaSetelahDiskonBarang;
      });
    }
  }

  int jumlahBarangDalamKeranjang(Barang barang) {
    return keranjang.containsKey(barang) ? keranjang[barang]! : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barang Transaksi'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.listBarang.length,
              itemBuilder: (context, index) {
                final barang = widget.listBarang[index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 4.0),
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
                              RichText(
                                text: TextSpan(
                                  text: 'Stok: ${barang.stokBarang}  ',
                                  style: GoogleFonts.getFont(
                                    'Inria Sans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    height: 1.3,
                                    color: Color(0xFF8B8E99),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 78.8,
                                child: Text(
                                  'Rp. ${barang.hargaSetelahDiskonBarang.toStringAsFixed(2)}',
                                  style: GoogleFonts.getFont(
                                    'Inria Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    height: 1.3,
                                    color: Color(0xFF8B8E99),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        if (jumlahBarang > 0 &&
                            jumlahBarangDalamKeranjang(barang) > 0)
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            color: Color(0xFF8B8E99),
                            iconSize: 30, // Ukuran ikon negatif diperbesar
                            onPressed: () {
                              kurangiBarang(barang);
                            },
                          ),
                        SizedBox(width: 5),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: jumlahBarangDalamKeranjang(barang) > 0
                                ? Colors.red
                                : Color(0xFF8B8E99),
                          ),
                          iconSize: 30, // Ukuran ikon tambah diperbesar
                          onPressed: () {
                            tambahBarang(barang);
                          },
                        ),
                        SizedBox(width: 5),
                        Text(
                          jumlahBarangDalamKeranjang(barang).toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (jumlahBarang > 0)
            Container(
              margin: EdgeInsets.fromLTRB(21, 0, 23, 0),
              decoration: BoxDecoration(
                color: Color(0xFF0ED622),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(12.3, 8, 10.5, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 2, 0, 4),
                          child: Text(
                            '$jumlahBarang',
                            style: GoogleFonts.getFont(
                              'Inria Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              height: 1.3,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 6.5, 8.9, 7.5),
                            child: Text(
                              'Rp. ${totalHarga.toStringAsFixed(2)}',
                              style: GoogleFonts.getFont(
                                'Inria Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                height: 1.3,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransaksiPage(
                                    keranjang: keranjang.keys.toList(),
                                    totalHarga:
                                        totalHarga, // Tambahkan totalHarga sebagai parameter
                                  ),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
