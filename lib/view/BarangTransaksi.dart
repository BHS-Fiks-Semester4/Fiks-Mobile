import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/models/DataBarang.dart';
import 'package:mobile/Main-Class/TransaksiPage.dart';
import 'package:mobile/models/DataTransaksi.dart';
import 'package:mobile/models/login_response/user.dart';

class BarangTransaksi extends StatefulWidget {
  final List<Barang> listBarang;
  final User currentUser; // Assuming `User` is the class of your currentUser object


   const BarangTransaksi({
    Key? key,
    required this.listBarang,
    required this.currentUser,
  }) : super(key: key);


  @override
  _BarangTransaksiState createState() => _BarangTransaksiState();
}

class _BarangTransaksiState extends State<BarangTransaksi> {
  int jumlahBarang = 0;
  double totalHarga = 0.0;
  int qty = 0;
  Map<Barang, int> keranjang = {};
  User currentUser = User();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = widget.currentUser;
  }
  void tambahBarang(Barang barang) {
    setState(() {
      if (keranjang.containsKey(barang)) {
        if (keranjang[barang]! < barang.stokBarang) {
          keranjang[barang] = keranjang[barang]! + 1;
          jumlahBarang++;
          totalHarga += barang.hargaSetelahDiskonBarang;
        } else {
          // Jika jumlah yang ditambahkan melebihi stok, tampilkan pesan atau lakukan tindakan lain
          print("Stok barang ${barang.namaBarang} sudah habis.");
        }
      } else {
        keranjang[barang] = 1;
        jumlahBarang++;
        totalHarga += barang.hargaSetelahDiskonBarang;
      }
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

  int getTotalQty(Map<Barang, int> keranjang) {
    int totalQty = 0;
    keranjang.forEach((barang, qty) {
      totalQty += qty;
    });
    return totalQty;
  }

  Map<Barang, int> getBarangQtyMap() {
    Map<Barang, int> barangQtyMap = {};
    keranjang.forEach((barang, qty) {
      if (qty > 0) {
        barangQtyMap[barang] = qty;
      }
    });
    return barangQtyMap;
  }
  Map<Barang, double> getSubTotal() {
  Map<Barang, double> subTotalMap = {};
  keranjang.forEach((barang, qty) {
    if (qty > 0) {
      // Assuming hargaSetelahDiskonBarang is a property of Barang that holds the price after discount
      double subtotal = barang.hargaSetelahDiskonBarang .toDouble()* qty;
      subTotalMap[barang] = subtotal;
    }
  });
  return subTotalMap;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (jumlahBarang > 0 &&
                                jumlahBarangDalamKeranjang(barang) > 0)
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline),
                                color: Color(0xFF8B8E99),
                                iconSize: 30,
                                onPressed: () {
                                  kurangiBarang(barang);
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
                            SizedBox(width: 5),
                            IconButton(
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: jumlahBarangDalamKeranjang(barang) > 0
                                    ? Colors.red
                                    : Color(0xFF8B8E99),
                              ),
                              iconSize: 30,
                              onPressed: () {
                                // Periksa apakah jumlah barang dalam keranjang telah mencapai stok maksimum
                                if (jumlahBarangDalamKeranjang(barang) <
                                    barang.stokBarang) {
                                  tambahBarang(barang);
                             
                                } else {
                                  // Tampilkan pesan notifikasi jika stok barang sudah habis
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Stok barang ${barang.namaBarang} sudah habis.'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
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
                              Map<Barang, int> barangQtyMap = getBarangQtyMap();
                                  var firstBarangId = keranjang.keys.toList().first.id; // Asumsi setiap barang memiliki field id

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransaksiPage(
                                    keranjang: keranjang.keys.toList(),
                                    barangQtyMap: barangQtyMap,
                                    totalHarga: totalHarga,
                                    qty: getTotalQty(keranjang),
                                    jumlahBarang: jumlahBarang,
                                    currentUser: widget.currentUser,
                                    hargaSetelahDiskonBarang: getSubTotal() ,
                                    id: firstBarangId, // Assuming currentUser has an id field

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