import 'package:flutter/material.dart';
import 'service/service_index.dart';
import 'service/service_create.dart';
import 'service/service_pending.dart';
import 'service/service_on_progress.dart';
import 'service/service_done.dart';

void navigateToServicePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ServiceIndexPage()),
  );
}

void navigateToCreateService(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ServiceCreatePage())  
  );
}

void navigateToPendingService(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ServicePendingPage())  
  );
}

void navigateToOnProgressService(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ServiceOnProgressPage())  
  );
}

void navigateToDoneService(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ServiceDonePage())  
  );
}
