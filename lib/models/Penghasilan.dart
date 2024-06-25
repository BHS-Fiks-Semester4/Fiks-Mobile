import 'dart:convert';

class PenghasilanBersih {
  final String bulananPenghasilan;
  final String harianPenghasilan;
  final String bulananPengeluaran;
  final String harianPengeluaran;

  PenghasilanBersih({
    required this.bulananPenghasilan,
    required this.harianPenghasilan,
    required this.bulananPengeluaran,
    required this.harianPengeluaran,
  });

  factory PenghasilanBersih.fromJson(Map<String, dynamic> json) {
    return PenghasilanBersih(
      bulananPenghasilan: json['penghasilan']['bulanan'],
      harianPenghasilan: json['penghasilan']['harian'],
      bulananPengeluaran: json['pengeluaran']['bulanan'],
      harianPengeluaran: json['pengeluaran']['harian'],
    );
  }
}
