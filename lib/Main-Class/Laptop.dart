import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Laptop extends StatefulWidget {
  const Laptop({super.key});

  @override
  State<Laptop> createState() => _LaptopState();
}

class _LaptopState extends State<Laptop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.fromLTRB(19, 0, 19, 3.5),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SizedBox(
                  width: 166,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 3, 3.9, 2.9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 2, 6.5, 2.1),
                          child: SizedBox(
                            width: 128.5,
                            child: Text(
                              'Cari barang...',
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
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 63, 2, 28),
                            borderRadius: BorderRadius.circular(8.6),
                          ),
                          child: Container(
                            width: 17.1,
                            height: 17.1,
                            padding: EdgeInsets.fromLTRB(3.4, 3.4, 4.3, 4.3),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                    'assets/images/search.png',
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 9.4,
                                height: 9.4,
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
          Container(
            margin: EdgeInsets.fromLTRB(19, 0, 21, 5.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: SizedBox(
                    width: 276.3,
                    child: Text(
                      'Kategori',
                      style: GoogleFonts.getFont( 
                        'Inria Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.3,
                        color: Color(0xFF8B8E99),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 3.5, 0, 3.5),
                  child: Text(
                    'View all',
                    style: GoogleFonts.getFont(
                      'Inria Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      height: 1.3,
                      color: Color(0xFF7A95FF),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(19, 0, 21, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFFFD006B),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                      child: Text(
                        'All',
                        style: GoogleFonts.getFont(
                          'Inria Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          height: 1.3,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
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
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                      child: Text(
                        'VGA',
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
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
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
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                      child: Text(
                        'SSD',
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
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
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
                      padding: EdgeInsets.fromLTRB(9.7, 2, 9.7, 2),
                      child: Text(
                        'Keyboard',
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
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
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
                      padding: EdgeInsets.fromLTRB(12.6, 2, 12.6, 2),
                      child: Text(
                        'Monitor',
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
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(19, 0, 20, 9),
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
          Container(
            margin: EdgeInsets.fromLTRB(19, 0, 20, 9),
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
          Container(
            margin: EdgeInsets.fromLTRB(19, 0, 20, 9),
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
          Container(
            margin: EdgeInsets.fromLTRB(19, 0, 20, 9),
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
          Container(
            margin: EdgeInsets.fromLTRB(19, 0, 20, 9),
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
          Container(
            margin: EdgeInsets.fromLTRB(19, 0, 20, 9),
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
          Container(
            margin: EdgeInsets.fromLTRB(19, 0, 20, 9),
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
        ]),
      ),
    );
  }
}
