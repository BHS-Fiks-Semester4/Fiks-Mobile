import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile/models/DataBarang.dart';

class DataBarangWidget extends StatelessWidget {
  final List<Barang> listBarang;

  const DataBarangWidget({Key? key, required this.listBarang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listBarang.length,
      itemBuilder: (context, index) {
        final barang = listBarang[index];
        return ListTile(
          title: Text(barang.namaBarang),
          subtitle: Text('Stok: ${barang.stokBarang}'),
          leading: SizedBox(
            width: 80,
            height: 80,
            child: _buildImage(barang.gambarBarang),
          ),
        );
      },
    );
  }

  Widget _buildImage(String base64String) {
    if (_isBase64(base64String)) {
      try {
        final decodedBytes = base64.decode(base64String);
        return Image.memory(decodedBytes);
      } catch (e) {
        print('Error decoding base64 string: $e');
        return Placeholder();
      }
    } else {
      print('Invalid base64 string: $base64String');
      return Placeholder();
    }
  }

  bool _isBase64(String value) {
    try {
      base64.decode(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
