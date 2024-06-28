import 'package:flutter/material.dart';
import 'package:mobile/Main-Class/navigate.dart';

class ServiceDoneUnpaidPage extends StatefulWidget {
  const ServiceDoneUnpaidPage({super.key});

  @override
  State<ServiceDoneUnpaidPage> createState() => _ServiceDoneUnpaidPageState();
}

class _ServiceDoneUnpaidPageState extends State<ServiceDoneUnpaidPage> {
  final TextEditingController _searchController = TextEditingController();

  // Sample data
  List<Map<String, String>> doneServices = [
    {'name': 'Service 1', 'type': 'Type A', 'date': '2023-06-05'},
    {'name': 'Service 2', 'type': 'Type B', 'date': '2023-06-06'},
    {'name': 'Service 3', 'type': 'Type C', 'date': '2023-06-07'},
    {'name': 'Service 4', 'type': 'Type D', 'date': '2023-06-08'},
    {'name': 'Service 5', 'type': 'Type E', 'date': '2023-06-05'},

  ];

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
                    labelText: 'Search done services',
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
                    _buildSectionHeader(title: 'Done Unpaid'),
                    ..._buildServiceCards(doneServices),
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

  Widget _buildSectionHeader({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<Widget> _buildServiceCards(List<Map<String, String>> services) {
    return services.map((service) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(service['name'] ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type: ${service['type']}'),
                  Text('Date: ${service['date']}'),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
