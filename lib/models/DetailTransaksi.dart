class DetailTransaksi {
  final String idTransaksi;
  final DateTime tanggalTransaksi;
  final double totalHarga;
  final List<TransaksiItem> daftarItem;

  DetailTransaksi({
    required this.idTransaksi,
    required this.tanggalTransaksi,
    required this.totalHarga,
    required this.daftarItem,
  });

  // Metode untuk mengonversi JSON ke objek DetailTransaksi
  factory DetailTransaksi.fromJson(Map<String, dynamic> json) {
    return DetailTransaksi(
      idTransaksi: json['idTransaksi'],
      tanggalTransaksi: DateTime.parse(json['tanggalTransaksi']),
      totalHarga: json['totalHarga'].toDouble(),
      daftarItem: List<TransaksiItem>.from(json['daftarItem'].map((item) => TransaksiItem.fromJson(item))),
    );
  }

  // Metode untuk mengonversi objek DetailTransaksi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'idTransaksi': idTransaksi,
      'tanggalTransaksi': tanggalTransaksi.toIso8601String(),
      'totalHarga': totalHarga,
      'daftarItem': daftarItem.map((item) => item.toJson()).toList(),
    };
  }
}

class TransaksiItem {
  final String namaItem;
  final int jumlah;
  final double harga;

  TransaksiItem({
    required this.namaItem,
    required this.jumlah,
    required this.harga,
  });

  // Metode untuk mengonversi JSON ke objek TransaksiItem
  factory TransaksiItem.fromJson(Map<String, dynamic> json) {
    return TransaksiItem(
      namaItem: json['namaItem'],
      jumlah: json['jumlah'],
      harga: json['harga'].toDouble(),
    );
  }

  // Metode untuk mengonversi objek TransaksiItem ke JSON
  Map<String, dynamic> toJson() {
    return {
      'namaItem': namaItem,
      'jumlah': jumlah,
      'harga': harga,
    };
  }
}