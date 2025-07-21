import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<List<String>> fetchLocation() async {
    try {
      // Check if service is enabled
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          print('❌ Location service not enabled.');
          return ['0.0', '0.0'];
        }
      }

      // Check permission
      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          print('❌ Location permission not granted.');
          return ['0.0', '0.0'];
        }
      }

      // Get location
      LocationData position = await _location.getLocation();
      return [position.latitude.toString(), position.longitude.toString()];
    } catch (e) {
      print('🚨 Error fetching location: $e');
      return ['0.0', '0.0'];
    }
  }
}
