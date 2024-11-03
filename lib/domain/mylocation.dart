import 'package:geocoding/geocoding.dart';

class MyLocation {
  double latitude;
  double longitude;
  String? fullAddress;
  String? pinCode;
  String? cityName;
  MyLocation({required this.latitude, required this.longitude});

  Future<void> setFullAddress() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

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

      print("Your Address for ($latitude, $longitude) is: $address");

      fullAddress = address;
    } catch (e) {
      print("Error getting placemarks: $e");
      fullAddress = "No Address";
    }
  }

  Future<void> setCityName() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      var address = '';

      if (placemarks.isNotEmpty) {
        address += ', ${placemarks.reversed.last.locality ?? ''}';
      }

      print("Your Address for is: $address");

      cityName = address;
    } catch (e) {
      print("Error getting placemarks: $e");
      cityName = "No City found";
    }
  }

  Future<void> setPinCode() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      var address = '';

      if (placemarks.isNotEmpty) {
        address += ', ${placemarks.reversed.last.postalCode ?? ''}';
      }

      print("Your Address for  is: $address");

      pinCode = address;
    } catch (e) {
      print("Error getting placemarks: $e");
      pinCode = "No City found";
    }
  }
}
