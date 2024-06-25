import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile/view/kategori.dart';
import 'package:mobile/models/pengeluaran.dart';
import 'package:intl/intl.dart';
import 'package:mobile/models/Penghasilan.dart';
import 'package:mobile/models/transaksi.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/view/DatabaseHelper.dart';
import 'package:mobile/models/login_response/user.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user;
  List<dynamic> kategoriBarang = [];
  List<Transaksi> transaksiList = [];
  List<Pengeluaran> pengeluaranList = [];
  PenghasilanBersih? penghasilanBersih;
  User _currentUser = User();
  String selectedButton = '';
  String selectedMonth =
      DateTime.now().month.toString(); // Track selected month
  final TextEditingController _searchController = TextEditingController();

  Future<void> fetchKategoriBarang() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/kategori'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'success') {
        kategoriBarang = data['kategoris'];
      } else {
        throw Exception('Failed to load kategori');
      }
    } else {
      throw Exception('Failed to load kategori');
    }
  }

  Future<void> fetchTransactionsForMonth(String month) async {
    String baseUrl = 'http://127.0.0.1:8000/api/transaksi/';
    String fullUrl = baseUrl + month;
    Uri url = Uri.parse(fullUrl);

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final transaksiJson = data['transaksi'] as List;
        final pengeluaranJson = data['pengeluaran'] as List;

        setState(() {
          transaksiList =
              transaksiJson.map((json) => Transaksi.fromJson(json)).toList();
          pengeluaranList = pengeluaranJson
              .map((json) => Pengeluaran.fromJson(json))
              .toList();
          selectedButton = month; // Set selected button here
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<PenghasilanBersih> fetchPenghasilanBersih(String month) async {
    String baseUrl = 'http://127.0.0.1:8000/api/penghasilan-dan-pengeluaran/';
    String fullUrl = baseUrl + month;
    Uri url = Uri.parse(fullUrl);

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PenghasilanBersih.fromJson(data);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> loadPenghasilanBersih(String month) async {
    try {
      final penghasilan = await fetchPenghasilanBersih(month);
      setState(() {
        penghasilanBersih = penghasilan;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void loadCurrentMonthTransactions() {
    String currentMonth = DateTime.now().month.toString();
    fetchTransactionsForMonth(currentMonth);
    loadPenghasilanBersih(currentMonth);
  }

  Future<void> _loadUserData() async {
    final loggedInUserId = await DatabaseHelper().getLoggedInUserId();
    if (loggedInUserId != null) {
      final user = await DatabaseHelper().getUser(loggedInUserId);
      if (user != null) {
        setState(() {
          _currentUser = user;
        });
      }
    }
  }

  @override
  void initState() {
    fetchKategoriBarang();
    loadCurrentMonthTransactions();
    super.initState();
    _currentUser = widget.user;
    _loadUserData();
    // fetchUserData();
  }

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
                                  margin: EdgeInsets.fromLTRB(0, 0, 13, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      borderRadius: BorderRadius.circular(28.5),
                                    ),
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.circular(33),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(33),
                                        child: Image.memory(
                                          base64Decode(
                                              _currentUser.foto.toString()),
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Icons.image, size: 40);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 7, 0, 9),
                                  child: Text(
                                    'Welcome ${_currentUser.name}',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 22,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                            child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              width: 400,
                              height: 200,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(18, 21, 24.8, 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(7, 0, 7, 2),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'TOTAL PENGHASILAN',
                                          style: GoogleFonts.getFont(
                                            'Mitr',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(7, 0, 7, 16),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '${penghasilanBersih!.bulananPenghasilan}',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: SizedBox(
                                          width: 275.2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 2, 0, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 8, 0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.contain,
                                                            image: NetworkImage(
                                                              'assets/up.png',
                                                            ),
                                                          ),
                                                        ),
                                                        child: Container(
                                                          width: 31,
                                                          height: 31,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 6, 0, 9),
                                                      child: Text(
                                                        'Income',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Meera Inimai',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 1),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 9, 0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.contain,
                                                            image: NetworkImage(
                                                              'assets/down.png',
                                                            ),
                                                          ),
                                                        ),
                                                        child: Container(
                                                          width: 32,
                                                          height: 32,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 6, 0, 10),
                                                      child: Text(
                                                        'Expends',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Meera Inimai',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 5.5, 2),
                                            child: SizedBox(
                                              width: 150,
                                              child: Text(
                                                '${penghasilanBersih!.harianPenghasilan}',
                                                style: GoogleFonts.getFont(
                                                  'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Color(0xFF000000),
                                                ),
                                              ),
                                            ),
                                          ),
                                         Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 5.5, 2),
                                            child: SizedBox(
                                              width: 150,
                                              child: Text(
                                                '${penghasilanBersih!.harianPengeluaran}',
                                                style: GoogleFonts.getFont(
                                                  'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Color(0xFF000000),
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
                            ),
                          ),
                        ))
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
                    for (var kategori in kategoriBarang)
                      _buildCard(
                        context,
                        kategori['nama_jenis_barang'],
                        kategori['foto'],
                        kategori['id'],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var i = 1; i <= 12; i++)
                              MouseRegion(
                                onEnter: (_) {
                                  setState(() {
                                    selectedMonth = i.toString();
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    selectedMonth =
                                        DateTime.now().month.toString();
                                  });
                                },
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedButton = i.toString();
                                    });
                                    fetchTransactionsForMonth(i.toString());
                                    loadPenghasilanBersih(i.toString());
                                  },
                                  child: Text(getMonthName(i)),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 3,
                                    shadowColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ).copyWith(
                                    backgroundColor: MaterialStateProperty.all(
                                      selectedButton == i.toString()
                                          ? const Color.fromRGBO(253, 0, 107, 1)
                                          : Colors.white,
                                    ),
                                    foregroundColor: MaterialStateProperty.all(
                                      selectedButton == i.toString()
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Search on progress services',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: transaksiList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Tampilkan pop-up detail transaksi
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            title: Text(
                              'Detail Transaksi',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: transaksiList[index]
                                    .detailTransaksi
                                    .map<Widget>((detail) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 5.0),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Icon(Icons.label,
                                                  color: Colors.blue),
                                              SizedBox(width: 5),
                                              Text(
                                                'ID Barang: ${detail.idBarang}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.shopping_bag,
                                                  color: Colors.green),
                                              SizedBox(width: 5),
                                              Text(
                                                  'Nama Barang: ${detail.namaBarang}'),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.format_list_numbered,
                                                  color: Colors.orange),
                                              SizedBox(width: 5),
                                              Text('Quantity: ${detail.qty}'),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.attach_money,
                                                  color: Colors.red),
                                              SizedBox(width: 5),
                                              Text(
                                                  'Sub Total: ${detail.subTotal}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'Close',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text('Transaksi'),
                        subtitle: Text(
                          '${DateFormat('dd MMM yyyy').format(DateTime.parse(transaksiList[index].createdAt))}',
                        ),
                        trailing: Text(
                          "+ ${transaksiList[index].totalHarga.toString()}",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: pengeluaranList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Tampilkan pop-up detail pengeluaran
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            title: Text(
                              'Detail Pengeluaran',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 5.0),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Icon(Icons.label,
                                                  color: Colors.blue),
                                              SizedBox(width: 5),
                                              Text(
                                                'Nama Pengeluaran: ${pengeluaranList[index].namaPengeluaran}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.attach_money,
                                                  color: Colors.green),
                                              SizedBox(width: 5),
                                              Text(
                                                'Total Pengeluaran: ${pengeluaranList[index].totalPengeluaran}',
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.shopping_bag,
                                                  color: Colors.orange),
                                              SizedBox(width: 5),
                                              Text(
                                                  'Nama Barang: ${pengeluaranList[index].namaBarang}'),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.info,
                                                  color: Colors.red),
                                              SizedBox(width: 5),
                                              Text(
                                                  'Status: ${pengeluaranList[index].status}'),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.date_range,
                                                  color: Colors.purple),
                                              SizedBox(width: 5),
                                              Text(
                                                  '${DateFormat('dd MMM yyyy').format(DateTime.parse(pengeluaranList[index].createdAt))}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(pengeluaranList[index].namaPengeluaran),
                        subtitle: Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                                ' ${DateFormat('dd MMM yyyy').format(DateTime.parse(pengeluaranList[index].createdAt))}'),
                          ],
                        ),
                        trailing: Text(
                          "- ${pengeluaranList[index].totalPengeluaran.toString()}",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, String fotoBase64, int id) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailKategori(id: id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mengonversi base64 ke Image widget
            Image.memory(
              base64Decode(fotoBase64),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String getMonthName(int monthNumber) {
    List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[monthNumber - 1];
  }

  void _showDialogDetail(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
