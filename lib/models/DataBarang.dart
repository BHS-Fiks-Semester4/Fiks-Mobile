import 'dart:convert';

class Barang {
  final int id;
  final int idJenisBarang;
  final int idSupplier;
  final String namaBarang;
  final int stokBarang;
  final int hargaBeliBarang;
  final int hargaSebelumDiskonBarang;
  final int diskonBarang;
  final int hargaSetelahDiskonBarang;
  final String expDiskonBarang;
  final String garansiBarang;
  final String deskripsiBarang;
  final String fotoBarang; // Mengubah menjadi String untuk menyimpan base64 string
  final String status;
  final String? createdAt;
  final String? updatedAt;

  Barang({
    required this.id,
    required this.idJenisBarang,
    required this.idSupplier,
    required this.namaBarang,
    required this.stokBarang,
    required this.hargaBeliBarang,
    required this.hargaSebelumDiskonBarang,
    required this.diskonBarang,
    required this.hargaSetelahDiskonBarang,
    required this.expDiskonBarang,
    required this.garansiBarang,
    required this.deskripsiBarang,
    required this.fotoBarang,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id: json['id'],
      idJenisBarang: json['id_jenis_barang'],
      idSupplier: json['id_supplier'],
      namaBarang: json['nama_barang'],
      stokBarang: json['stok_barang'],
      hargaBeliBarang: json['harga_beli_barang'],
      hargaSebelumDiskonBarang: json['harga_sebelum_diskon_barang'],
      diskonBarang: json['diskon_barang'],
      hargaSetelahDiskonBarang: json['harga_setelah_diskon_barang'],
      expDiskonBarang: json['exp_diskon_barang'],
      garansiBarang: json['garansi_barang'],
      deskripsiBarang: json['deskripsi_barang'],
      fotoBarang: json['foto_barang'], // Mendapatkan base64 string
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  static List<Barang> parseBarangs(String responseBody) {
    final parsed =
        jsonDecode(responseBody)['barangs'].cast<Map<String, dynamic>>();
    return parsed.map<Barang>((json) => Barang.fromJson(json)).toList();
  }
}
