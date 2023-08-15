import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocatorLocationUpdates extends StatefulWidget {
  const GeoLocatorLocationUpdates({Key? key}) : super(key: key);

  @override
  State<GeoLocatorLocationUpdates> createState() => _GeoLocatorLocationUpdatesState();
}

class _GeoLocatorLocationUpdatesState extends State<GeoLocatorLocationUpdates> {

  final AndroidSettings _androidSettings = AndroidSettings(
      intervalDuration: const Duration(milliseconds: 20),
      distanceFilter: 10);
  final AppleSettings _appleSettings = AppleSettings(
    distanceFilter: 10,
    showBackgroundLocationIndicator: true
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              Geolocator.getPositionStream(locationSettings: _appleSettings).listen((position) {
                debugPrint("position: ${position.toJson()}");
                debugPrint('''\n
                        Latitude:  ${position.latitude}
                        Longitude: ${position.longitude}
                        Altitude: ${position.altitude}
                        Accuracy: ${position.accuracy}
                        Bearing:  ${position.heading}
                        Speed: ${position.speed}
                        Time: ${DateTime.now()}
                      ''');
              });
            },
            child: const Text('Start Location Service')),
        ElevatedButton(
            onPressed: () {

            },
            child: const Text('Stop Location Service')),
        ElevatedButton(
            onPressed: () {

            },
            child: const Text('Get Current Location')),
        ElevatedButton(
            onPressed: () {
              Geolocator.requestPermission().then((permission) {
                debugPrint(permission.toString());
              });
            },
            child: const Text('Get Permission')),
      ],
    );
  }
}
