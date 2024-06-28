import 'dart:convert';

class Service {
  final int id;
  final String namaService;
  final String deskripsiService;
  final String? foto;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Service({
    required this.id,
    required this.namaService,
    required this.deskripsiService,
    this.foto,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        namaService: json["nama_service"],
        deskripsiService: json["deskripsi_service"],
        foto: json["foto"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_service": namaService,
        "deskripsi_service": deskripsiService,
        "foto": foto,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

List<Service> serviceFromJson(String str) =>
    List<Service>.from(json.decode(str).map((x) => Service.fromJson(x)));

String serviceToJson(List<Service> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
