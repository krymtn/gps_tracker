import 'package:flutter/material.dart';
import 'package:gps_tracker/workmanager_demo.dart';
import 'isolates_example.dart';
import 'location_updates_background.dart';
import 'locations_update_with_geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GeoLocatorLocationUpdates(),
    );
  }
}
