import 'package:flutter/material.dart';
import 'package:mobile/Main-Class/api_service/ApiForService.dart';
import 'package:mobile/models/service_model/Service.dart';
import 'package:mobile/models/service_model/LayananService.dart';
import 'package:mobile/Main-Class/service/service_index.dart';

class ServiceCreatePage extends StatefulWidget {
  const ServiceCreatePage({super.key});

  @override
  _ServiceCreatePageState createState() => _ServiceCreatePageState();
}

class _ServiceCreatePageState extends State<ServiceCreatePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _namaCustomerController = TextEditingController();
  final TextEditingController _noHpCustomerController = TextEditingController();
  final TextEditingController _alamatCustomerController = TextEditingController();
  final TextEditingController _namaServiceController = TextEditingController();
  final TextEditingController tanggalService = TextEditingController();
  String _selectedJenisService = 'null'; 
  String _selectedStatusService = 'pending'; 
  DateTime _selectedDate = DateTime.now();

  // Dropdown menu items untuk status service
  final List<String> _statusServiceItems = ['pending', 'in_progress'];

  List<Service> _kategoriList = [];
  bool _isLoading = true;

  @override
    void initState() {
    super.initState();
    _fetchKategoriList();
  }

  Future<void> _fetchKategoriList() async {
    ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1:8000/api/layanan_service');
    try {
      List<Service> kategoriList = await apiService.getKategoriList();
      setState(() {
        _kategoriList = kategoriList;
        _kategoriList.insert(0, Service(id: 0, namaService: 'Pilih jenis service', deskripsiService: '', foto: null, status: '', createdAt: DateTime.now(), updatedAt: DateTime.now()));
        _selectedJenisService = _kategoriList.first.namaService;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _createService() async {
    if (formKey.currentState!.validate()) {
      int? idJenisService = _selectedJenisService == 'Pilih jenis service'
          ? null
          : _kategoriList.firstWhere((service) => service.namaService == _selectedJenisService).id;

      final layananService = LayananService(
        namaCustomer: _namaCustomerController.text,
        noHpCustomer: _noHpCustomerController.text,
        alamatCustomer: _alamatCustomerController.text,
        namaService: _namaServiceController.text,
        idJenisService: idJenisService,
        statusService: _selectedStatusService,
        statusBayar: 'belum',
        tanggalPenerimaan: _selectedDate,
      );

      try {
        ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1:8000/api/layanan_service');
        await apiService.createLayananService(layananService);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ServiceIndexPage()),
          );
      } catch (e) {
        Text('error: $e');
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Service'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _namaCustomerController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama customer tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Nama lengkap customer ",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _noHpCustomerController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nomor handphone customer tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Nomor handphone customer ",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _alamatCustomerController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Alamat customer tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Alamat customer ",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _namaServiceController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama service tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Nama service ",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : DropdownButtonFormField<String>(
                                value: _selectedJenisService,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedJenisService = value!;
                                  });
                                },
                                items: _kategoriList.map((Service kategori) {
                                  return DropdownMenuItem<String>(
                                    value: kategori.namaService,
                                    child: Text(kategori.namaService),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  labelText: 'Jenis service',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: DropdownButtonFormField<String>(
                          value: _selectedStatusService,
                          onChanged: (value) {
                            setState(() {
                              _selectedStatusService = value!;
                            });
                          },
                          items: _statusServiceItems.map((String status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Status service',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: tanggalService,
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal service tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Tanggal service',
                            suffixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _createService,
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(290, 50)),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                        child: Text(
                          'Add service',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        tanggalService.text = "${_selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    _namaCustomerController.dispose();
    _noHpCustomerController.dispose();
    _alamatCustomerController.dispose();
    _namaServiceController.dispose();
    super.dispose();
  }
}
