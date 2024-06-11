class Pengeluaran {
  final int totalPengeluaran;

  Pengeluaran({required this.totalPengeluaran});

  factory Pengeluaran.fromJson(Map<String, dynamic> json) {
    return Pengeluaran(
      totalPengeluaran: json['total_pengeluaran'],
    );
  }
}