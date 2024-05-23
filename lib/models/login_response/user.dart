import 'dart:convert';

class User {
  int? id;
  String? name;
  String? email;
  String? username;
  String? alamat;
  String? noHp;
  String? agama;
  String? tanggalLahir;
  String? role;
  String? status;
  String? foto; // Mengubah menjadi String untuk menyimpan base64 string
  dynamic createdAt;
  dynamic updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.username,
    this.alamat,
    this.noHp,
    this.agama,
    this.tanggalLahir,
    this.role,
    this.status,
    this.foto,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'] as int?,
      name: data['name'] as String?,
      email: data['email'] as String?,
      username: data['username'] as String?,
      alamat: data['alamat'] as String?,
      noHp: data['no_hp'] as String?,
      agama: data['agama'] as String?,
      tanggalLahir: data['tanggal_lahir'] as String?,
      role: data['role'] as String?,
      status: data['status'] as String?,
      foto: data['foto'] as String?, // Mendapatkan base64 string
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'username': username,
        'alamat': alamat,
        'no_hp': noHp,
        'agama': agama,
        'tanggal_lahir': tanggalLahir,
        'role': role,
        'status': status,
        'foto': foto,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  String toString() {
    return 'UserData{id: $id, name: $name, email: $email, username: $username, alamat: $alamat, noHp: $noHp, agama: $agama, tanggalLahir: $tanggalLahir, role: $role, status: $status, foto: $foto, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
