import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:pg_photo_track/data/repositories/recent_visit_provider.dart';
import 'package:pg_photo_track/model/response.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/utils/failure.dart';
import 'package:provider/provider.dart';

class PhotosViewGridScreen extends StatefulWidget {
  int visitId;
  String? category;
  PhotosViewGridScreen({super.key, required this.visitId, this.category});
  @override
  _PhotosViewGridScreenState createState() => _PhotosViewGridScreenState();
}

class _PhotosViewGridScreenState extends State<PhotosViewGridScreen> {
  List<dynamic> _images = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final recentPhotoProvider =
          Provider.of<RecentVisitProvider>(context, listen: false);
      recentPhotoProvider.fetchPhotosFromVisitId(widget.visitId);
    });
  }

  // Future<void> _getSdkVersion() async {
  //   if (Platform.isAndroid) {
  //     // Extract SDK version from the operating system version string
  //     final osVersion = Platform.operatingSystemVersion;
  //     final match = RegExp(r'API\s(\d+)').firstMatch(osVersion);
  //     String? sdkVersion;
  //     if (match != null) {
  //       sdkVersion = match.group(1); // Extracted SDK number
  //       print("sdk " + sdkVersion.toString());
  //     } else {
  //       print("unknown");
  //     }
  //   } else {
  //     print("error");
  //   }
  // }

  Future<bool> _getStoragePermission() async {
    bool _permissionGranted = false;
    //  if (android.version.sdkInt < 33) {
    if (await Permission.storage.request().isGranted) {
      _permissionGranted = true;
      //print("granted permission");
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.audio.request().isDenied) {
      //print("denied");
    }
    //   } else {
    ///print("storage");
    if (await Permission.photos.request().isGranted) {
      _permissionGranted = true;
      //print("psermission granted");
    } else if (await Permission.photos.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.photos.request().isDenied) {
      // print("no granted");
    }
    return _permissionGranted;
  }

  Future<void> _downloadImage(String base64Image, int index) async {
    // Check and request storage permission
    final status = await _getStoragePermission();
    if (status) {
      try {
        // Decode Base64 image to bytes
        final bytes = base64Decode(base64Image);
        Directory? dwnDir = Directory("");
        if (Platform.isAndroid) {
          // Redirects it to download folder in android
          dwnDir = Directory("/storage/emulated/0/Download");
        } else {
          dwnDir = await getDownloadsDirectory();
        }
        // final Directory? dwnDir = await getDownloadsDirectory();

        final String directoryPath = path.join(
          dwnDir!.path,
          'FIELDPHOTO',
        );

        // Create the directory if it does not exist
        final Directory newDir = Directory(directoryPath);
        if (!newDir.existsSync()) {
          await newDir.create(recursive: true);
        }

        // Define the image path
        final String imagePath = path.join(newDir.path,
            '${widget.category} ${widget.visitId}-${index + 1}.jpg');

        // Save the image to the specified path
        // final File newImage = await File(imageFile.path).copy(imagePath);
        final File newImage = await File(imagePath).create();

        // Get the directory for saving files
        // final directory = await getExternalStorageDirectory();
        // final path = directory?.path ?? '';
        // final file = File('$path/image_$index.jpg');

        // Save the file
        await newImage.writeAsBytes(bytes);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image downloaded: ${newImage.absolute}')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download image: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  @override
  void didChangeDependencies() async {
    //print("did");
    // await _getAndroidVersion();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final recentPhotoProvider =
        Provider.of<RecentVisitProvider>(context, listen: false);
    final response =
        await recentPhotoProvider.fetchPhotosFromVisitId(widget.visitId);
    if (response is Failure) {
      recentPhotoProvider.errorMessage = response.messege;
    } else {
      _images = (response as List<dynamic>);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photo Gallery')),
      body: _images.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.memory(
                            base64Decode(_images[index].photo!),
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 70,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Latitude : ${(_images[index] as VisitPhotosReponse).photoLat}',
                                        style: getMediumStyle(
                                            fontColor: ColorManager.darkgrey,
                                            fontSize: FontSize.mediumLargeSize),
                                      ),
                                      Text(
                                        'Longitude : ${(_images[index] as VisitPhotosReponse).photoLng}',
                                        style: getMediumStyle(
                                            fontColor: ColorManager.darkgrey,
                                            fontSize: FontSize.mediumLargeSize),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await _getStoragePermission();
                                      await _downloadImage(
                                          (_images[index] as VisitPhotosReponse)
                                              .photo!,
                                          index);
                                    },
                                    icon: Icon(
                                      Icons.download_for_offline,
                                      size: 50,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
