import 'package:geolocator/geolocator.dart';

class LocationHelper {
  //check if user turn on the GPS
  //desiredAccuracy it's meaning how much of quality you want in select current location (high)
  static Future<Position> getMyCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
