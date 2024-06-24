import 'package:flutter/material.dart';

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
  String _selectedJenisService = 'laptop'; // Default jenis service
  String _selectedStatusService = 'pending'; // Default status service
  DateTime _selectedDate = DateTime.now(); // Default tanggal service

  // Dropdown menu items for jenis service
  final List<String> _jenisServiceItems = ['laptop', 'computer', 'perangkat lain'];

  // Dropdown menu items for status service
  final List<String> _statusServiceItems = ['pending', 'in progress'];

  @override
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
                            hintText: "Masukkan nama customer",
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
                            hintText: "Masukkan nomor handphone customer",
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
                            hintText: "Masukkan alamat customer",
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
                            hintText: "Masukkan nama service",
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
                        child: DropdownButtonFormField<String>(
                          value: _selectedJenisService,
                          onChanged: (value) {
                            setState(() {
                              _selectedJenisService = value!;
                            });
                          },
                          items: _jenisServiceItems.map((String jenis) {
                            return DropdownMenuItem<String>(
                              value: jenis,
                              child: Text(jenis),
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
                            hintText: 'Pilih service',
                            suffixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            
                          }
                        },
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(290, 50)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.pink),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
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
