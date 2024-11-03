import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:image_picker/image_picker.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:pg_photo_track/domain/mylocation.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/route_manager.dart';
import 'package:pg_photo_track/presentation/string_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/utils/image_compress.dart';
import 'package:pg_photo_track/utils/locationinfo.dart';
import 'package:provider/provider.dart';

class CaptureReviewPhotos extends StatefulWidget {
  @override
  State<CaptureReviewPhotos> createState() => _CaptureReviewPhotosState();
}

class _CaptureReviewPhotosState extends State<CaptureReviewPhotos> {
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
    return Scaffold(
      appBar: AppBar(title: const Text("Review Photos")),
      body: Column(
        children: [
          Expanded(
            child: ((_visitDetailProvider?.photos.length ?? 0) == 0)
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hourglass_empty_outlined),
                      SizedBox(width: 8),
                      Text('No Photos available'),
                    ],
                  )
                : ListView.builder(
                    itemCount: _visitDetailProvider!.photos.length,
                    itemBuilder: (context, index) {
                      final photoDetail = _visitDetailProvider!.photos[index];
                      return
                          // Card(
                          //   child: ListTile(
                          //     leading: Image.file(
                          //       photoDetail.photo,
                          //       width: 150,
                          //       height: 150,
                          //       fit: BoxFit.cover,
                          //     ),
                          //     // title: Text(photoDetail.label),
                          //     subtitle: Text(
                          //         "Remark: ${photoDetail.remark}\nLat: ${photoDetail.latitude}\nLng: ${photoDetail.longitude}"),
                          //   ),
                          // );
                          Card(
                        child: Container(
                          child: Row(
                            children: [
                              Image.file(
                                photoDetail.photo,
                                width: 150,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                              Expanded(
                                child: Text(
                                  "Remark: ${photoDetail.remark}\nLat: ${photoDetail.latitude}\nLng: ${photoDetail.longitude}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    _visitDetailProvider!
                                        .deletePhoto(photoDetail);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 50,
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary),
                      onPressed: (_visitDetailProvider?.photos.length ?? 0) > 0
                          ? () {
                              Navigator.pushNamed(context, Routes.reviewSubmit);
                            }
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Done',
                                  style: getMediumStyle(
                                      fontColor: ColorManager.white,
                                      fontSize: FontSize.mediumToLargeSize)),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary),
                      onPressed: () async {
                        await _capturePhoto();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('ADD PHOTO',
                                  style: getMediumStyle(
                                      fontColor: ColorManager.white,
                                      fontSize: FontSize.mediumToLargeSize)),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          )
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
