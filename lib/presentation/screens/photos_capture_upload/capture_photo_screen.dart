import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pg_photo_track/data/providers/photo_provider.dart';
import 'package:provider/provider.dart';

class CapturePhotoScreen extends StatefulWidget {
  @override
  _CapturePhotoScreenState createState() => _CapturePhotoScreenState();
}

class _CapturePhotoScreenState extends State<CapturePhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  double? latitude, longitude;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _captureAndUploadPhoto() async {
    // Pick Image from Camera
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) return;

    // Fetch Location
    // _locationData = await _locationService.getLocation();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Extract latitude and longitude
    latitude = position.latitude;
    longitude = position.longitude;
    // Show loading indicator
    setState(() => _isUploading = true);

    // Call provider to upload photo
    final photoProvider = Provider.of<PhotoProvider>(context, listen: false);
    await photoProvider.uploadPhoto(
      File(photo.path),
      latitude!,
      longitude!,
    );

    // Hide loading indicator
    setState(() => _isUploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Capture and Upload Photo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isUploading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _captureAndUploadPhoto,
                    child: Text("Capture and Upload"),
                  ),
          ],
        ),
      ),
    );
  }
}
