import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:pg_photo_track/domain/mylocation.dart';
import 'package:pg_photo_track/utils/error_handling.dart';

import 'failure.dart';

class LocationInfo {
  static Future<dynamic> getUserLocation() async {
    loc.Location location = loc.Location();
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        //return failure ofbject
        return Failure(ResponseCode.LOCATION_SERVICE_ERROR,
            ResponseMessage.LOCATION_SERVICE_ERROR);
      }
    }
    if (location == null) {
      return Failure(ResponseCode.LOCATION_SERVICE_ERROR,
          "Error Fetching your Location Info.");
    }
    //Check if permission is granted
    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        //return failure object
        return Failure(ResponseCode.PERMISSION_LOCATION_ERROR,
            ResponseMessage.PERMISSION_LOCATION_ERROR);
      }
    }
    final locationData = await location.getLocation();
    print("latitude" + locationData.latitude.toString());

    return MyLocation(
        latitude: locationData.latitude!, longitude: locationData.longitude!)
      ..setFullAddress()
      ..setCityName()
      ..setPinCode();
  }

  Future<String> getPlacemarks(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

      var address = '';

      if (placemarks.isNotEmpty) {
        // Concatenate non-null components of the address
        var streets = placemarks.reversed
            .map((placemark) => placemark.street)
            .where((street) => street != null);

        // Filter out unwanted parts
        streets = streets.where((street) =>
            street!.toLowerCase() !=
            placemarks.reversed.last.locality!
                .toLowerCase()); // Remove city names
        streets = streets
            .where((street) => !street!.contains('+')); // Remove street codes

        address += streets.join(', ');

        address += ', ${placemarks.reversed.last.subLocality ?? ''}';
        address += ', ${placemarks.reversed.last.locality ?? ''}';
        address += ', ${placemarks.reversed.last.subAdministrativeArea ?? ''}';
        address += ', ${placemarks.reversed.last.administrativeArea ?? ''}';
        address += ', ${placemarks.reversed.last.postalCode ?? ''}';
        address += ', ${placemarks.reversed.last.country ?? ''}';
      }

      print("Your Address for ($lat, $long) is: $address");

      return address;
    } catch (e) {
      print("Error getting placemarks: $e");
      return "No Address";
    }
  }
}
