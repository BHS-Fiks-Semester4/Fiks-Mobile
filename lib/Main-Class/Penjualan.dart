import 'package:flutter/material.dart';

class Penjualan extends StatefulWidget {
  const Penjualan({Key? key}) : super(key: key);

  @override
  State<Penjualan> createState() => _PenjualanState();
}

class _PenjualanState extends State<Penjualan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjualan'),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Aksi untuk tombol pencarian
              },
              child: Text('Search'),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Textfield 1',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Textfield 2',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Column 1')),
                    DataColumn(label: Text('Column 2')),
                    // Tambahkan kolom lain sesuai kebutuhan
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Row 1, Cell 1')),
                      DataCell(Text('Row 1, Cell 2')),
                      // Tambahkan sel lain sesuai kebutuhan
                    ]),
                  ],
                  // Tambahkan baris lain sesuai kebutuhan
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Textfield 3',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Textfield 4',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Aksi untuk tombol
              },
              child: Text('Button'),
            ),
          ],
        ),
      ),
    );
  }
}
