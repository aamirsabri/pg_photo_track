import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoProvider with ChangeNotifier {
  Future<void> uploadPhoto(
      File photo, double latitude, double longitude) async {
    final url = Uri.parse(
        'https://yourserver.com/upload'); // Replace with your upload URL

    final request = http.MultipartRequest('POST', url)
      ..fields['latitude'] = latitude.toString()
      ..fields['longitude'] = longitude.toString()
      ..files.add(await http.MultipartFile.fromPath('photo', photo.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      print("Photo uploaded successfully");
    } else {
      print("Photo upload failed with status: ${response.statusCode}");
    }
  }
}
