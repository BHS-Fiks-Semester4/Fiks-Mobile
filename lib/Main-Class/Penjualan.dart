import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TransaksiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF000000),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                    'assets/images/signal.png',
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 14,
                                height: 14,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                    'assets/images/wi_fi.png',
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 14,
                                height: 14,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                    'assets/images/charged_battery.png',
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 14,
                                height: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(19, 0, 19, 24),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 195.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                    'assets/images/left_arrow.png',
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 23,
                                height: 23,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                              child: Text(
                                'Penjualan',
                                style: GoogleFonts.getFont(
                                  'Inria Sans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  height: 1.3,
                                  color: Color(0xFF8B8E99),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 0, 24, 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nama Customer',
                        style: GoogleFonts.getFont(
                          'Inria Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          height: 1.3,
                          color: Color(0xFF8B8E99),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 0, 24, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        width: 312,
                        height: 28,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 0, 24, 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Kode barang',
                        style: GoogleFonts.getFont(
                          'Inria Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          height: 1.3,
                          color: Color(0xFF8B8E99),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 0, 24, 6.5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        width: 312,
                        height: 28,
                      ),
                    ),
                  ),
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
                    margin: EdgeInsets.fromLTRB(24, 0, 26.9, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 7.5, 0),
                          child: SizedBox(
                            width: 173.3,
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
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                          child: Text(
                            '1x',
                            style: GoogleFonts.getFont(
                              'Inria Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                              height: 1.3,
                              color: Color(0xFF8B8E99),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                          child: Text(
                            'Rp. 85.000',
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
                    margin: EdgeInsets.fromLTRB(257.1, 0, 0, 15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        '1',
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
                    margin: EdgeInsets.fromLTRB(24, 0, 26.9, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 7.5, 0),
                          child: SizedBox(
                            width: 173.3,
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
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                          child: Text(
                            '1x',
                            style: GoogleFonts.getFont(
                              'Inria Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                              height: 1.3,
                              color: Color(0xFF8B8E99),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                          child: Text(
                            'Rp. 85.000',
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
                    margin: EdgeInsets.fromLTRB(28, 0, 28, 15),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 6.5, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                    'assets/images/minus.png',
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 18,
                                height: 18,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 2, 3.4, 2),
                            child: Text(
                              '1',
                              style: GoogleFonts.getFont(
                                'Inria Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                                height: 1.3,
                                color: Color(0xFF8B8E99),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                  'assets/images/plus.png',
                                ),
                              ),
                            ),
                            child: Container(
                              width: 18,
                              height: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 0, 26.9, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 7.5, 0),
                          child: SizedBox(
                            width: 173.3,
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
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                          child: Text(
                            '1x',
                            style: GoogleFonts.getFont(
                              'Inria Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                              height: 1.3,
                              color: Color(0xFF8B8E99),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                          child: Text(
                            'Rp. 85.000',
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
                    margin: EdgeInsets.fromLTRB(257.1, 0, 0, 1.5),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        '1',
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
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFCFCFCF)),
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFFFFFFF),
                          ),
                          child: Container(
                            width: 308,
                            height: 26,
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
                              'Bayar',
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
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFCFCFCF)),
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFFFFFFF),
                          ),
                          child: Container(
                            width: 308,
                            height: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFCFCFCF)),
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFFFFFFF),
                          ),
                          child: Container(
                            width: 308,
                            height: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(26, 0, 26, 190),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFFD006B)),
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFFD006B),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Lakukan aksi submit di sini
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
          ],
        ),
      ),
    );
  }
}



