import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/Main-Class/navigate.dart';
import 'package:mobile/models/service_model/LayananService.dart';
import 'package:mobile/Main-Class/api_service/ApiForService.dart';

class ServiceIndexPage extends StatefulWidget {
  const ServiceIndexPage({super.key});

  @override
  State<ServiceIndexPage> createState() => _ServiceIndexPageState();
}

class _ServiceIndexPageState extends State<ServiceIndexPage> {
  final TextEditingController _searchController = TextEditingController();

  final ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1:8000/api/layanan_service');

  List<LayananService> pendingServices = [];
  List<LayananService> inProgressServices = [];
  List<LayananService> doneUnpaidServices = [];
  List<LayananService> donePaidServices = [];

  @override

  void initState() {
      super.initState();
      fetchServices();
    }

  Future<void> fetchServices() async {
    try {
      pendingServices = await apiService.getPendingServices();
      inProgressServices = await apiService.getInProgressServices();
      doneUnpaidServices = await apiService.getDoneUnpaidServices();
      donePaidServices = await apiService.getDonePaidServices();
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
        title: const Text('Service'),
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
                    labelText: 'Search service',
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
                    _buildSectionHeader(
                      title: 'Pending',
                      onViewAll: () => navigateToPendingService(context),
                    ),
                    ..._buildPendingInProgressServiceCards(pendingServices),
                    _buildSectionHeader(
                      title: 'On Progress',
                      onViewAll: () => navigateToInProgressService(context),
                    ),
                    ..._buildPendingInProgressServiceCards(inProgressServices),
                    _buildSectionHeader(
                      title: 'Done Unpaid',
                      onViewAll: () => navigateToDoneUnpaidService(context),
                    ),
                    ..._buildUnpaidServiceCards(doneUnpaidServices),
                    _buildSectionHeader(
                      title: 'Done Paid',
                      onViewAll: () => navigateToDonePaidService(context),
                    ),
                    ..._buildPaidServiceCards(donePaidServices),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToCreateService(context),
        tooltip: 'Add Service',
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required VoidCallback onViewAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onViewAll,
              child: const Text(
                'View All',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
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
  List<Widget> _buildUnpaidServiceCards(List<LayananService> services) {
    return services.map((service) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(service.namaService ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer: ${service.namaCustomer ?? ''}'),
                  Text('No hp customer: ${service.noHpCustomer ?? ''}'),
                  Text('Tanggal penerimaan: ${service.tanggalPenerimaan.toString()}'),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildPaidServiceCards(List<LayananService> services) {
    return services.map((service) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(service.namaService ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer: ${service.namaCustomer ?? ''}'),
                  Text('No hp customer: ${service.noHpCustomer ?? ''}'),
                  Text('Tanggal selesai: ${service.tanggalSelesai.toString()}'),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

