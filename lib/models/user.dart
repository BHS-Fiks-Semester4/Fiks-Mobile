import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String username;
  final String name;
  final String email;
  final String alamat;
  final String agama;
  final String tanggal_lahir;

  User({
    required this.username,
    required this.name,
    required this.email,
    required this.alamat,
    required this.agama,
    required this.tanggal_lahir,
  
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
