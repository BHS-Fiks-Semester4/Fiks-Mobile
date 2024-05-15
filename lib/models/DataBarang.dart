import 'dart:convert';

class Barang {
  final int id;
  final String namaBarang;
  final int stokBarang;
  final double hargaSatuanBarang;
  final String garansi;
  final int diskon;
  final DateTime expDiskon;
  final String idJenis;
  final String gambarBarang; // Simpan gambar sebagai String

  Barang({
    required this.id,
    required this.namaBarang,
    required this.stokBarang,
    required this.hargaSatuanBarang,
    required this.garansi,
    required this.diskon,
    required this.expDiskon,
    required this.idJenis,
    required this.gambarBarang,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
  return Barang(
    id: json['id'] ?? 0, // Ganti 0 dengan nilai default yang sesuai
    namaBarang: json['nama-barang'] ?? '', // Gunakan nilai default jika null
    stokBarang: json['stok-barang'] ?? 0, // Ganti 0 dengan nilai default yang sesuai
    hargaSatuanBarang: (json['harga-satuan-barang'] ?? 0).toDouble(), // Ganti 0 dengan nilai default yang sesuai
    garansi: json['garansi'] ?? '', // Gunakan nilai default jika null
    diskon: json['diskon'] ?? 0, // Ganti 0 dengan nilai default yang sesuai
    expDiskon: DateTime.parse(json['exp-diskon'] ?? '2000-01-01'), // Gunakan tanggal default jika null
    idJenis: json['id-jenis'] ?? '', // Gunakan nilai default jika null
    gambarBarang: json['gambar-barang'] ?? '', // Gunakan nilai default jika null
  );
}


  static List<Barang> parseBarangs(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Barang>((json) => Barang.fromJson(json)).toList();
  }
}
