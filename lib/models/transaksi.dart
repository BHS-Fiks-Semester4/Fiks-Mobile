class Transaksi {
  final int totalHarga;

  Transaksi({required this.totalHarga});

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      totalHarga: json['total_harga'],
    );
  }
}