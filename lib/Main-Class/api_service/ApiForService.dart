import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/service_model/LayananService.dart';
import 'package:mobile/models/Kategori.dart';

class ApiService{
  final String baseUrl;

  ApiService({required this.baseUrl});


  Future<List<LayananService>> getLayananServiceList() async {
    final response = await http.get(Uri.parse('$baseUrl/layanan_service'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => LayananService.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load layanan service');
    }
  }


  Future<LayananService> getLayananServiceDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/layanan_service/$id'));

    if (response.statusCode == 200) {
      return LayananService.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load layanan service detail');
    }
  }


  Future<void> getLayananService(LayananService layananService) async {
    final response = await http.post(
      Uri.parse('$baseUrl/layanan_service'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(layananService.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add layanan service');
    }
  }


  Future<void> updateLayananService(int id, LayananService layananService) async {
    final response = await http.put(
      Uri.parse('$baseUrl/layanan_service/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(layananService.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update layanan service');
    }
  }


  Future<void> deleteLayananService(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/layanan_service/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete layanan service');
    }
  }


  Future<List<Kategori>> getKategoriList() async {
    final response = await http.get(Uri.parse('$baseUrl/create'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Kategori.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load kategori');
    }
  }

}