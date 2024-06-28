import 'package:flutter/material.dart';
import 'service/service_index.dart';
import 'service/service_create.dart';
import 'service/service_pending.dart';
import 'service/service_in_progress.dart';
import 'service/service_done_unpaid.dart';
import 'service/service_done_paid.dart';

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

void navigateToInProgressService(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ServiceInProgressPage())  
  );
}

void navigateToDoneUnpaidService(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ServiceDoneUnpaidPage())  
  );
}

void navigateToDonePaidService(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ServiceDonePaidPage())  
  );
}
