class Pengeluaran {
  final int totalPengeluaran;
  final String namaPengeluaran;
  final String namaBarang;
  final String status;
  final String createdAt;

  Pengeluaran({
    required this.totalPengeluaran,
    required this.namaPengeluaran,
    required this.namaBarang,
    required this.status,
    required this.createdAt,
  });

  factory Pengeluaran.fromJson(Map<String, dynamic> json) {
    return Pengeluaran(
      totalPengeluaran: json['total_pengeluaran'],
      namaPengeluaran: json['nama_pengeluaran'],
      namaBarang: json['nama_barang'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }
}