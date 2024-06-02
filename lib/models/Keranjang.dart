import 'package:meta/meta.dart';

class Keranjang {
  final String id;
  final String idKaryawan;
  final double totalHarga;
  final int qty;
  final double bayar;
  final double kembalian;

  Keranjang({
    required this.id,
    required this.idKaryawan,
    required this.totalHarga,
    required this.qty,
    required this.bayar,
    required this.kembalian,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_karyawan': idKaryawan,
      'total_harga': totalHarga,
      'qty': qty,
      'bayar': bayar,
      'kembalian': kembalian,
    };
  }
}

