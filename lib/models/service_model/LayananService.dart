import 'dart:convert';

class LayananService {
  int? id;
  String namaCustomer;
  String noHpCustomer;
  String alamatCustomer;
  int? idJenisService;
  String statusService;
  int? totalBayarService;
  String statusBayar;
  int? bayar;
  int? kembalian;
  DateTime tanggalPenerimaan;
  DateTime? tanggalSelesai;

  LayananService({
    this.id,
    required this.namaCustomer,
    required this.noHpCustomer,
    required this.alamatCustomer,
    this.idJenisService,
    required this.statusService,
    this.totalBayarService,
    required this.statusBayar,
    this.bayar,
    this.kembalian,
    required this.tanggalPenerimaan,
    this.tanggalSelesai,
  });

  factory LayananService.fromJson(Map<String, dynamic> json) => LayananService(
        id: json["id"],
        namaCustomer: json["nama_customer"],
        noHpCustomer: json["no_hp_customer"],
        alamatCustomer: json["alamat_customer"],
        idJenisService: json["id_jenis_service"],
        statusService: json["status_service"],
        totalBayarService: json["total_bayar_service"],
        statusBayar: json["status_bayar"],
        bayar: json["bayar"],
        kembalian: json["kembalian"],
        tanggalPenerimaan: DateTime.parse(json["tanggal_penerimaan"]),
        tanggalSelesai: json["tanggal_selesai"] != null
            ? DateTime.parse(json["tanggal_selesai"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_customer": namaCustomer,
        "no_hp_customer": noHpCustomer,
        "alamat_customer": alamatCustomer,
        "id_jenis_service": idJenisService,
        "status_service": statusService,
        "total_bayar_service": totalBayarService,
        "status_bayar": statusBayar,
        "bayar": bayar,
        "kembalian": kembalian,
        "tanggal_penerimaan": tanggalPenerimaan.toIso8601String(),
        "tanggal_selesai": tanggalSelesai?.toIso8601String(),
      };
}

List<LayananService> layananServiceFromJson(String str) =>
    List<LayananService>.from(json.decode(str).map((x) => LayananService.fromJson(x)));

String layananServiceToJson(List<LayananService> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
