class Transaksi {
  final int id;
  final double totalHarga;

  Transaksi({required this.id, required this.totalHarga});

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id: json['id'],
      totalHarga: json['total_harga'],
    );
  }
}