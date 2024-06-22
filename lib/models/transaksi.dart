class Transaksi {
  final int id;
  final int idKaryawan;
  final double totalHarga;
  final double bayar;
  final double kembalian;
  final String createdAt;
  final String updatedAt;
  final List<DetailTransaksi> detailTransaksi;

  Transaksi({
    required this.id,
    required this.idKaryawan,
    required this.totalHarga,
    required this.bayar,
    required this.kembalian,
    required this.createdAt,
    required this.updatedAt,
    required this.detailTransaksi,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    var list = json['detail_transaksi'] as List;
    List<DetailTransaksi> detailTransaksiList = list.map((i) => DetailTransaksi.fromJson(i)).toList();
    return Transaksi(
      id: json['id'],
      idKaryawan: json['id_karyawan'],
      totalHarga: json['total_harga'].toDouble(),
      bayar: json['bayar'].toDouble(),
      kembalian: json['kembalian'].toDouble(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] ?? '',
      detailTransaksi: detailTransaksiList,
    );
  }
}

class DetailTransaksi {
  final int id;
  final int idTransaksi;
  final String namaBarang;
  final int idBarang;
  final int qty;
  final double subTotal;

  DetailTransaksi({
    required this.id,
    required this.idTransaksi,
    required this.namaBarang,
    required this.idBarang,
    required this.qty,
    required this.subTotal,
  });

  factory DetailTransaksi.fromJson(Map<String, dynamic> json) {
    return DetailTransaksi(
      id: json['id'],
      idTransaksi: json['id_transaksi'],
      namaBarang: json['nama_barang'],
      idBarang: json['id_barang'],
      qty: json['qty'],
      subTotal: json['sub_total'].toDouble(),
    );
  }
}