import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:pg_photo_track/app/functions.dart';

class ImageCompressor {
  static Future<XFile> compressImage({
    required File? image,
    required int count,
    int quality = 50,
  }) async {
    CompressFormat format = CompressFormat.jpeg;
    final String targetPath =
        p.join(Directory.systemTemp.path, 'temp${count}.${format.name}');

    //await deleteFile(File(targetPath));
    // final XFile? compressedImage =
    //     await FlutterImageCompress.compressAndGetFile(image!.path, targetPath,
    //         quality: quality, format: format);
    var compressedImage = await FlutterImageCompress.compressAndGetFile(
        image!.path, targetPath,
        quality: quality);
    image = null;
    if (compressedImage == null) {
      throw ("Failed to compress the image");
    }

    return compressedImage as XFile;
  }
}
