import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:image_picker/image_picker.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:pg_photo_track/domain/mylocation.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/route_manager.dart';
import 'package:pg_photo_track/presentation/screens/visit/review_submit_screen.dart';
import 'package:pg_photo_track/presentation/string_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/widgets/custom_button.dart';
import 'package:pg_photo_track/presentation/widgets/image_capture_widget.dart';
import 'package:pg_photo_track/utils/image_compress.dart';
import 'package:pg_photo_track/utils/locationinfo.dart';
import 'package:provider/provider.dart';

class CapturePhotoScreen extends StatefulWidget {
  @override
  State<CapturePhotoScreen> createState() => _CapturePhotoScreenState();
}

class _CapturePhotoScreenState extends State<CapturePhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  double? latitude, longitude;

  VisitDetailProvider? _visitDetailProvider;

  Future<void> _capturePhoto() async {
    // EasyLoading.showInfo("Fetching Location...",
    //     duration: Duration(seconds: 5));
    // await LocationInfo.getUserLocation().then((mylocation) {
    //   latitude = mylocation.latitude;
    //   longitude = mylocation.longitude;
    // });
    int count = _visitDetailProvider!.photos.length;
    EasyLoading.show();
    // Pick Image from Camera
    XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) {
      EasyLoading.dismiss();
      return;
    }
    EasyLoading.showInfo("Compressing Image...",
        duration: Duration(seconds: 5));
    XFile? compressedPhoto = await ImageCompressor.compressImage(
        image: File(photo.path), count: count);
    if (compressedPhoto == null) {
      print("error in compressing");
    } else {
      // print("main file lenght in bytes");
      // print(await photo.length());
      photo = compressedPhoto;
      // print("\ncompressed  file lenght in bytes");
      // print(await photo.length());
    }

    // Fetch Location
    EasyLoading.showInfo("Fetching Location...",
        duration: Duration(seconds: 5));
    // Position position = await Geolocator.getCurrentPosition(
    EasyLoading.show();
    //     // desiredAccuracy: LocationAccuracy.high,
    //     );

    // MyLocation location = await LocationInfo.getUserLocation();
    // print("lcoation complete");
    // // // Extract latitude and longitude
    // latitude = location!.latitude;
    // longitude = location!.longitude;

    // Save photo with details in provider

    _visitDetailProvider!.addPhoto(
      File(photo!.path)!,
      null,
      latitude,
      longitude,
    );
    EasyLoading.dismiss();
    EasyLoading.showSuccess('Photo added successfully');
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text("Photo added successfully")),
    // );
    _visitDetailProvider!.updateLocation();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // _visitDetailProvider =
    //     Provider.of<VisitDetailProvider>(context, listen: true);
    // _visitDetailProvider!.updateLocation();
    super.didChangeDependencies();
    ModalRoute.of(context);
  }

  Future<void> saveCapturedPhoto(XFile? photo) async {
    if (photo == null) {
      EasyLoading.dismiss();
      print('photo is null');
      return;
    }
    EasyLoading.showInfo("Compressing Image...",
        duration: Duration(seconds: 5));
    XFile? compressedPhoto =
        await ImageCompressor.compressImage(image: File(photo.path), count: 0);
    if (compressedPhoto == null) {
      print("error in compressing");
    } else {
      // print("main file lenght in bytes");
      // print(await photo.length());
      photo = compressedPhoto;
      // print("\ncompressed  file lenght in bytes");
      // print(await photo.length());
    }

    // Fetch Location
    EasyLoading.showInfo("Fetching Location...",
        duration: Duration(seconds: 5));
    // Position position = await Geolocator.getCurrentPosition(
    EasyLoading.show();
    //     // desiredAccuracy: LocationAccuracy.high,
    //     );

    // MyLocation location = await LocationInfo.getUserLocation();
    // print("lcoation complete");
    // // // Extract latitude and longitude
    // latitude = location!.latitude;
    // longitude = location!.longitude;

    // Save photo with details in provider

    _visitDetailProvider!.addPhoto(
      File(photo!.path)!,
      null,
      latitude,
      longitude,
    );
    EasyLoading.dismiss();
    EasyLoading.showSuccess('Photo added successfully');
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text("Photo added successfully")),
    // );
    print("_vosot photo length ${_visitDetailProvider!.photos.length}");
    _visitDetailProvider!.updateLocation();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _visitDetailProvider = _visitDetailProvider =
          Provider.of<VisitDetailProvider>(context, listen: false);
      _visitDetailProvider!.updateLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VisitDetailProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Take and Submit Photo")),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
            onPressed: ((provider?.photos?.isEmpty) ?? true)
                ? null
                : () {
                    Navigator.pushNamed(context, Routes.reviewSubmit);
                  },
            child: Text('Next - Submit Photo',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: ColorManager.white,
                    fontSize: FontSize.mediumLargeSize))),
      ),
      body: Column(
        children: [
          CaptureImageWidget(
              image: (((provider?.photos?.isEmpty) ?? true)
                  ? null
                  : provider?.photos[0].photo),
              saveCapturedImage: (XFile? file) async {
                if (file != null) {
                  saveCapturedPhoto(file!);
                }
              }),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.navigate_next),
      //   onPressed: () async {
      //     // await provider.uploadAllPhotos();
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text("Photos uploaded successfully")),
      //     );
      //   },
      // ),
    );
  }
}
