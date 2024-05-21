import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/Main-Class/Laptop.dart';
import 'package:mobile/view/Management.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                    _buildCard(context, 'Laptop', Icons.laptop, Laptop()),
                    _buildCard(context, 'HardWare', Icons.hardware,Recyclerview()),

                    _buildCard(context, 'Barang', Icons.repartition, cctv()),
                    _buildCard(
                        context, 'Elektronik', Icons.devices, Elektronik()),
                    _buildCard(
                        context, 'Komputer', Icons.device_hub, Komputer()),
                    _buildCard(
                        context, 'Gadget', Icons.developer_board, Gadget()),
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

  Widget _buildCard(
      BuildContext context, String title, IconData icon, Widget Laptop) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Laptop),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(icon, size: 50, color: Colors.pink),
                SizedBox(height: 10),
                Text(
                  title,
                  style: GoogleFonts.getFont(
                    'Inria Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    height: 1.3,
                    color: Color(0xFFFD006B),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCard(
    BuildContext context, String title, IconData icon, Widget Recyclerview) {
  return Container(
    margin: EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Recyclerview),
        );
      },
    ),
  );
}

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

// Kelas-kelas dummy untuk target navigasi
class Hardware extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hardware"),
      ),
      body: Center(
        child: Text("Halaman Hardware"),
      ),
    );
  }
}

class cctv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barang"),
      ),
      body: Center(
        child: Text("Halaman Barang"),
      ),
    );
  }
}

class Elektronik extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Elektronik"),
      ),
      body: Center(
        child: Text("Halaman Elektronik"),
      ),
    );
  }
}

class Komputer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Komputer"),
      ),
      body: Center(
        child: Text("Halaman Komputer"),
      ),
    );
  }
}

class Gadget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gadget"),
      ),
      body: Center(
        child: Text("Halaman Gadget"),
      ),
    );
  }
}
class Recyclerview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gadget"),
      ),
      body: Center(
        child: Text("Halaman Gadget"),
      ),
    );
  }
}