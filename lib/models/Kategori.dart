import 'dart:convert';

class Kategori {
  final int id;
  final String namaJenisBarang;
  final String foto; // Menyimpan base64 string
  final String status;
  final  dynamic createdAt;
  final  dynamic updatedAt;

  Kategori({
    required this.id,
    required this.namaJenisBarang,
    required this.foto,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        id: json["id"],
        namaJenisBarang: json["nama_jenis_barang"],
        foto: json["foto"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_jenis_barang": namaJenisBarang,
        "foto": foto,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

List<Kategori> kategoriFromJson(String str) =>
    List<Kategori>.from(json.decode(str).map((x) => Kategori.fromJson(x)));

String kategoriToJson(List<Kategori> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
