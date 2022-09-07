import 'package:ayiconnect_web/services/http_services.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class LocationServices {
  static Location? location;

  static Future<void> initService() async {
    location = Location();
    if (location != null) {
      await location!.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: 1000,
      );
    }
  }

  static bool? serviceEnabled;
  static PermissionStatus? permissionGranted;
  static LocationData? locationData;

  static Future<void> checkServiceEnable() async {
    serviceEnabled = await location?.serviceEnabled();
    if (!serviceEnabled!) {
      serviceEnabled = await location?.requestService();
      if (!serviceEnabled!) {
        return;
      }
    }
  }

  static Future<void> checkPermission() async {
    permissionGranted = await location?.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location?.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  static Future<void> getLocation() async {
    locationData = await location?.getLocation();
    debugPrint('locationData: $locationData');
    HttpServices.lat = locationData?.latitude.toString() ?? '';
    HttpServices.long = locationData?.longitude.toString() ?? '';
  }
}
