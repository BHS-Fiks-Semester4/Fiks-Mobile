import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/main.dart';

class Register extends StatefulWidget {
  final String? emailFromRegister;

  const Register({Key? key, this.emailFromRegister}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _secured = true;
  bool _secure = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _namalengkap = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _date = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController _alamat = TextEditingController();
  TextEditingController _confirmpw = TextEditingController();
  TextEditingController _nohp = TextEditingController();
  TextEditingController _selectedRegionController =
      TextEditingController(text: 'Pilih Agama');
  String selectedRegion = 'Pilih Agama';
  List<String> _items = ['Pilih Agama', 'Islam', 'Hindu', 'Budha'];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _namalengkap,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Masukkan Nama Lengkap",
                            labelText: "Nama Lengkap ",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _alamat,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Alamat tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Masukkan Alamat",
                            labelText: "Alamat",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _username,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Masukkan Username",
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "Masukkan Email",
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            bool isValidEmail =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value);
                            if (!isValidEmail) {
                              return 'Format email tidak valid';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _secure,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Masukkan Password",
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _secure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _secure = !_secure;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _confirmpw,
                          obscureText: _secured,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Konfirmasi Password tidak boleh kosong';
                            }
                            if (value != _passwordController.text) {
                              return 'Konfirmasi Password tidak sesuai dengan Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Konfirmasi Password",
                            labelText: "Konfirmasi Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _secured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _secured = !_secured;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _date,
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal Lahir tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Tanggal Lahir',
                            hintText: 'Pilih Tanggal Lahir',
                            suffixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          key: _key,
                          readOnly: true,
                          controller: _selectedRegionController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == 'Pilih Agama') {
                              return 'Agama harus dipilih';
                            }
                            return null;
                          },
                          onTap: () {
                            _showPopupMenu(context);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: () {
                                _showPopupMenu(context);
                              },
                            ),
                            suffixIconConstraints:
                                BoxConstraints(minWidth: 24, minHeight: 24),
                          ),
                        ),
                      ),
                       Container(
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          controller: _nohp,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Masukkan No HP",
                            labelText: "Nomer HP",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String namaLengkap = _namalengkap.text;
                            String username = _username.text;
                            String alamat = _alamat.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String confirmPassword = _confirmpw.text;
                            String tanggalLahir = _date.text;
                            String agama = _selectedRegionController.text;
                            String noHP = _nohp.text;
                            _verifyLogin(
                                namaLengkap,
                                username,
                                alamat,
                                email,
                                password,
                                confirmPassword,
                                tanggalLahir,
                                agama,
                                noHP);
                          }
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(290, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ))
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainApp(),),
                            );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      )
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
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _date.text =
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      });
    }
  }

  void _showPopupMenu(BuildContext context) async {
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, 1000, 0, 0),
      items: _items.map((String item) {
        return PopupMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
    if (result != null) {
      setState(() {
        _selectedRegionController.text = result;
      });
    }
  }

 Future<void> _verifyLogin(
  String namaLengkap,
  String username,
  String alamat,
  String email,
  String password,
  String confirmPassword,
  String tanggalLahir,
  String agama,
  String noHP) async {
  
  try {
    var response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/register-mobile'),
      body: {
        'name': namaLengkap, // Ubah namaLengkap menjadi name sesuai dengan backend
        'username': username,
        'alamat': alamat,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword, // Konfirmasi password tidak diperlukan di sini
        'tanggal_lahir': tanggalLahir, // Ubah tanggalLahir menjadi tanggal_lahir sesuai dengan backend
        'agama': agama,
        'no_hp': noHP, // Ubah noHP menjadi no_hp sesuai dengan backend
      },
    );

    if (response.statusCode == 201) { // Perubahan status code sesuai dengan respons yang diharapkan dari backend
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') { // Ubah pengecekan status sesuai dengan respons dari backend
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(email: email),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
       
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect to the server')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $e')),
    );
  }
}

}
