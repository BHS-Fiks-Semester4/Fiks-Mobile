// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      alamat: json['alamat'] as String,
      agama: json['agama'] as String,
      tanggal_lahir: json['tanggal_lahir'] as String,
      no_hp: json['no_hp'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'email': instance.email,
      'alamat': instance.alamat,
      'agama': instance.agama,
      'tanggal_lahir': instance.tanggal_lahir,
      'no_hp': instance.no_hp,
      'id': instance.id,
    };
