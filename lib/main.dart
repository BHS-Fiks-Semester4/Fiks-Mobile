import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/LupaPassword.dart';
import 'HomePage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _secure = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Enter your email",
                        labelText: "Email",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextField(
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
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      _verifyLogin(email, password);
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => lupaPassword()),
                      );
                    },
                    child: Text('Lupa Kata Sandi?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _verifyLogin(String email, String password) async {
    // Kirim permintaan HTTP ke server untuk verifikasi login
    var response = await http.post(
      Uri.parse('http://localhost/Fiks-Mobile/lib/login.php'),
      body: {'email': email, 'password': password},
    );

    // Periksa status kode respons
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        // Navigasi ke halaman beranda jika login berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Tampilkan pesan kesalahan jika login gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      }
    } else {
      // Tampilkan pesan kesalahan jika gagal terhubung ke server
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect to the server')),
      );
    }
  }
}
