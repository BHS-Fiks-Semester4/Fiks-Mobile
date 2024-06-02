
import 'package:meta/meta.dart';

class DataTransaksi {
  final int id;
  final int idKaryawan;
  final int totalHarga;
  final int bayar;
  final int kembalian;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DataTransaksi({
    required this.id,
    required this.idKaryawan,
    required this.totalHarga,
    required this.bayar,
    required this.kembalian,
    this.createdAt,
    this.updatedAt,
  });

  factory DataTransaksi.fromJson(Map<String, dynamic> json) => DataTransaksi(
        id: json['id'] as int,
        idKaryawan: json['id_karyawan'] as int,
        totalHarga: json['total_harga'] as int,
        bayar: json['bayar'] as int,
        kembalian: json['kembalian'] as int,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_karyawan': idKaryawan,
        'total_harga': totalHarga,
        'bayar': bayar,
        'kembalian': kembalian,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
