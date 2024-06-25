import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/models/DataBarang.dart';

class StrukPage extends StatelessWidget {
  final String transactionId;
  final String formattedDate;
  final double totalHarga;
  final double bayar;
  final double kembalian;
  final Map<Barang, int> barangQtyMap;

  const StrukPage({
    Key? key,
    required this.transactionId,
    required this.formattedDate,
    required this.totalHarga,
    required this.bayar,
    required this.kembalian,
    required this.barangQtyMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Struk Transaksi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Akhwat Komputer',
                style: GoogleFonts.getFont(
                  'Inria Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Jl. Contoh No. 123, Kota ABC',
                style: GoogleFonts.getFont(
                  'Inria Sans',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(height: 8),
            Divider(thickness: 2, color: Colors.black),
            SizedBox(height: 8),
            _buildInfoRow('ID Transaksi', transactionId),
            _buildInfoRow('Tanggal', formattedDate),
            Divider(thickness: 2, color: Colors.black),
            SizedBox(height: 16),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: barangQtyMap.length,
              itemBuilder: (context, index) {
                var entry = barangQtyMap.entries.toList()[index];
                var barang = entry.key;
                var qty = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          barang.namaBarang,
                          style: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '$qty x',
                          style: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Rp. ${(barang.hargaSetelahDiskonBarang * qty).toStringAsFixed(2)}',
                          style: GoogleFonts.getFont(
                            'Inria Sans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Divider(thickness: 2, color: Colors.black),
            _buildInfoRow(
                'Total Harga', 'Rp. ${totalHarga.toStringAsFixed(2)}'),
            _buildInfoRow('Bayar', 'Rp. ${bayar.toStringAsFixed(2)}'),
            _buildInfoRow('Kembalian', 'Rp. ${kembalian.toStringAsFixed(2)}'),
            SizedBox(height: 16),
            Center(
              child: Text(
                'Terima Kasih Telah Berbelanja',
                style: GoogleFonts.getFont(
                  'Inria Sans',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: GoogleFonts.getFont(
              'Inria Sans',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.getFont(
              'Inria Sans',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
