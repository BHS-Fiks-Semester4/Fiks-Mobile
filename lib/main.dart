import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/LupaPassword.dart';
import 'package:mobile/register.dart';
import 'HomePage.dart';
import 'package:mobile/view/Home.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:mobile/models/login_response/login_response.dart';
import 'package:mobile/models/login_response/user.dart';
import 'package:quickalert/quickalert.dart';
import 'package:mobile/view/DatabaseHelper.dart';
import 'package:mobile/models/login_response/user.dart'; // Ensure this path is correct
import 'package:mobile/view/Home.dart'; // Assuming this is where your HomePage or LoginPage is

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  final String? email;

  const LoginPage({Key? key, this.email}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _secure = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Key for Form
  bool _isEmailValid = true;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 600,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Enter your Email",
                          labelText: "Email",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          bool isValidEmail =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value);
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _secure,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _secure ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _secure = !_secure;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty!';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          _verifyLogin(email, password, context);
                        }
                      },
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(290, 50)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LupaPassword()),
                            );
                          },
                          child: Text(
                            'Forgotten password?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _verifyLogin(
      String email, String password, BuildContext context) async {
    try {
      // Kirim permintaan HTTP ke server untuk verifikasi login
      var response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/api/login-mobile?email=$email&password=$password'),
      );

      // Periksa status kode respons
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        LoginResponse loginResponse = LoginResponse.fromMap(responseData);
        if (loginResponse.status == 'success') {
          User? user = loginResponse.user;
          if (user != null) {
            user.id = responseData['id']; // Atur ID pengguna dari respons

            // Simpan data pengguna ke dalam database lokal
            DatabaseHelper dbHelper = DatabaseHelper();
            await dbHelper.insertUser(user);

            print('User: $user');
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: 'Login Successful!',
            );
            Future.delayed(Duration(seconds: 1), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(homePage: user!)),
              );
            });
          }
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: loginResponse.message ?? 'Login failed',
          );
        }
      } else {
        // Tangani kesalahan HTTP
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: 'Email or Password is incorrectaa',
        );
      }
    } catch (e) {
      // Tangani kesalahan lainnya
      print('Error: $e');
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'An error occurred while logging in',
      );
    }
  }
}
