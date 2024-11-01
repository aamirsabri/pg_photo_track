import 'package:location/location.dart';
import 'package:pg_photo_track/domain/mylocation.dart';
import 'package:pg_photo_track/utils/error_handling.dart';

import 'failure.dart';

class LocationInfo {
  static Future<dynamic> getUserLocation() async {
    Location location = Location();
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
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        //return failure object
        return Failure(ResponseCode.PERMISSION_LOCATION_ERROR,
            ResponseMessage.PERMISSION_LOCATION_ERROR);
      }
    }
    final locationData = await location.getLocation();
    print("latitude" + locationData.latitude.toString());

    return MyLocation(
        latitude: locationData.latitude!, longitude: locationData.longitude!);
  }
}
