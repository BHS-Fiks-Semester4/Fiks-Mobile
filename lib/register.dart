import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _secure = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _namalengkap = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _date = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController _alamat = TextEditingController();
  TextEditingController _confirmpw = TextEditingController();
  TextEditingController _agama = TextEditingController();
  TextEditingController _nohp = TextEditingController();
  String selectedRegion = 'Pilih Agama';
  List<String> _items = ['Pilih Agama', 'Islam', 'Hindu', 'Budha'];
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 700,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    width: 300,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextField(
                      controller: _namalengkap,
                      decoration: const InputDecoration(
                        hintText: "Masukkan Nama",
                        labelText: "Nama",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextField(
                      controller: _username,
                      decoration: const InputDecoration(
                        hintText: "Masukkan Username",
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Masukkan Email",
                        labelText: "Email",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Masukkan Password",
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Masukkan Password",
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      controller: TextEditingController(text: selectedRegion),
                      onTap: () {
                        _showPopupMenu(context);
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Item',
                        border: OutlineInputBorder(),
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
                  const SizedBox(height: 16),
                ],
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
      firstDate: DateTime(1),
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
    final RenderBox textFieldRenderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final Offset textFieldOffset =
        textFieldRenderBox.localToGlobal(Offset.zero);
    final double textFieldWidth = textFieldRenderBox.size.width;
    final double textFieldHeight = textFieldRenderBox.size.height;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        textFieldOffset.dx,
        textFieldOffset.dy + textFieldHeight,
        textFieldOffset.dx + textFieldWidth,
        textFieldOffset.dy + textFieldHeight * 2,
      ),
      items: _items.map((String item) {
        return PopupMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );

    if (result != null) {
      setState(() {
        selectedRegion = result;
      });
    }
  }

  void register() {
    String namaLengkap = _namalengkap.text;
    String username = _username.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmpw.text;
    String tanggalLahir = _date.text;
    String agama = selectedRegion;

    // Validasi jika password tidak sesuai dengan konfirmasi
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Password dan konfirmasi password tidak cocok.'),
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
      return;
    }
  }
}
