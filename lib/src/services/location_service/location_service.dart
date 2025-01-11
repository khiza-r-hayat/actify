                                                                                      import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When permissions are granted, get the position
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> getAddressFromLatLng(Position position) async {
    try {
      Position position = await _getGeoLocationPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[1];
      //log('place marks: ${placemarks[1]}');
      return "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
    } catch (e) {
      log('$e');
      return 'Failed to get address';
    }
  }

  Future<String> getCurrentAddress() async {
    try {
      Position position = await _getGeoLocationPosition();
      return await getAddressFromLatLng(position);
    } catch (e) {
      return 'Failed to get location';
    }
  }
}
