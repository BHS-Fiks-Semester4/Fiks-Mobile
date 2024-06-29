  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:mobile/models/service_model/Service.dart';
  import 'package:mobile/models/service_model/LayananService.dart';

  class ApiService{
    final String baseUrl;

    ApiService({required this.baseUrl});


    Future<List<LayananService>> getPendingServices() async {
      final response = await http.get(Uri.parse('$baseUrl/pending'));

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        List<dynamic> servicesJson = jsonResponse['pendings'];
        return servicesJson.map((data) => LayananService.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load pending services');
      }
    }

    Future<List<LayananService>> getInProgressServices() async {
      final response = await http.get(Uri.parse('$baseUrl/in_progress'));

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        List<dynamic> servicesJson = jsonResponse['in_progress'];
        return servicesJson.map((data) => LayananService.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load pending services');
      }
    }

    Future<List<LayananService>> getDoneUnpaidServices() async {
      final response = await http.get(Uri.parse('$baseUrl/done_unpaid'));

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        List<dynamic> servicesJson = jsonResponse['done_unpaids'];
        return servicesJson.map((data) => LayananService.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load pending services');
      }
    }

    Future<List<LayananService>> getDonePaidServices() async {
      final response = await http.get(Uri.parse('$baseUrl/done_paid'));

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        List<dynamic> servicesJson = jsonResponse['done_paids'];
        return servicesJson.map((data) => LayananService.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load pending services');
      }
    }


    Future<List<LayananService>> getPendingServicesAll() async {
      final response = await http.get(Uri.parse('$baseUrl/pending_all'));

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        List<dynamic> servicesJson = jsonResponse['pendings'];
        return servicesJson.map((data) => LayananService.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load pending services');
      }
    }

    Future<List<LayananService>> getInProgressServicesAll() async {
      final response = await http.get(Uri.parse('$baseUrl/in_progress_all'));

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        List<dynamic> servicesJson = jsonResponse['in_progress'];
        return servicesJson.map((data) => LayananService.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load pending services');
      }
    }

    Future<List<LayananService>> getDoneUnpaidServicesAll() async {
      final response = await http.get(Uri.parse('$baseUrl/done_unpaid_all'));

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        List<dynamic> servicesJson = jsonResponse['done_unpaids'];
        return servicesJson.map((data) => LayananService.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load pending services');
      }
    }

    Future<List<LayananService>> getDonePaidServicesAll() async {
      final response = await http.get(Uri.parse('$baseUrl/done_paid_all'));

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        List<dynamic> servicesJson = jsonResponse['done_paids'];
        return servicesJson.map((data) => LayananService.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load pending services');
      }
    }


    Future<List<Service>> getKategoriList() async {
      final response = await http.get(Uri.parse('$baseUrl/create'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['kategoris'];
        return jsonResponse.map((data) => Service.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load kategori');
      }
    }


    Future<void> createLayananService(LayananService layananService) async {
      final url = Uri.parse('$baseUrl');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(layananService.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create layanan service');
      }
    }
  }

