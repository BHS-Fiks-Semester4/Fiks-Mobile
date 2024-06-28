import 'package:flutter/material.dart';
import 'package:mobile/Main-Class/navigate.dart';
import 'package:mobile/models/service_model/LayananService.dart';
import 'package:mobile/Main-Class/api_service/ApiForService.dart';

class ServicePendingPage extends StatefulWidget {
  const ServicePendingPage({super.key});

  @override
  State<ServicePendingPage> createState() => _ServicePendingPageState();
}

class _ServicePendingPageState extends State<ServicePendingPage> {
  final TextEditingController _searchController = TextEditingController();

  final ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1:8000/api/layanan_service');

  List<LayananService> pendingServices = [];

  void initState() {
      super.initState();
      fetchServices();
    }

  Future<void> fetchServices() async {
    try {
      pendingServices = await apiService.getPendingServicesAll();
      setState(() {

      });
    } catch (e) {
      print('Error fetching services: $e');
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Service Pending'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search service pending',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ..._buildPendingInProgressServiceCards(pendingServices),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
  List<Widget> _buildPendingInProgressServiceCards(List<LayananService> services) {
    return services.map((service) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(service.namaService, style: TextStyle(fontWeight:FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer: ${service.namaCustomer ?? ''}'),
                  Text('Jenis service: ${service.idJenisService}'), 
                  Text('Tanggal penerimaan: ${service.tanggalPenerimaan}'), 
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
}
