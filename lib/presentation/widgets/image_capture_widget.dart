import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/widgets/custom_button.dart';

class CaptureImageWidget extends StatefulWidget {
  File? image;
  final Function(XFile? capturedImage) saveCapturedImage;
  CaptureImageWidget({this.image, required this.saveCapturedImage});
  @override
  _CaptureImageWidgetState createState() => _CaptureImageWidgetState();
}

class _CaptureImageWidgetState extends State<CaptureImageWidget> {
  File? _imageFile; // Variable to store the captured image
  final ImagePicker _picker = ImagePicker();

  // Function to capture a photo using the camera
  Future<void> _capturePhoto() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Store the captured image
      });
    }
    widget.saveCapturedImage(pickedFile);
  }

  @override
  Widget build(BuildContext context) {
    print('image ');
    print('image ${widget?.image?.path}');
    if (_imageFile == null) _imageFile = widget.image;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        // Display the captured image in a container
        _imageFile != null
            ? Container(
                margin: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.file(_imageFile!, fit: BoxFit.cover),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.grey),
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[700],
                  size: 50,
                ),
              ),
        SizedBox(
          height: 32,
        ),

        ElevatedButton(
          onPressed: _capturePhoto, // Capture photo on button press
          child: Text(
            'Take Photo',
            style: getMediumStyle(
                fontColor: ColorManager.white,
                fontSize: FontSize.mediumLargeSize),
          ),
        ),
      ],
    );
  }
}
