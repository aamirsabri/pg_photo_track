import 'package:pg_photo_track/app/api_constants.dart';
import 'package:pg_photo_track/app/apis.dart';
import 'package:pg_photo_track/app/constants.dart';
import 'package:pg_photo_track/domain/user.dart';
import 'package:pg_photo_track/model/photo_model.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/model/visit_detail.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pg_photo_track/utils/error_handling.dart';
import 'dart:io';

import 'package:pg_photo_track/utils/failure.dart';

class VisitRepository {
  Future<dynamic> getCategories() async {
    return await AppServiceClient.getAllPhotoCategories();
  }

  Future<dynamic> submitVisitDetailsWithPhotos({
    required VisitDetail visitDetail,
    UserModel? user,
    required List<PhotoDetail> photos,
  }) async {
    final url = Uri.parse(
        '${Constant.baseUrl + Constant.uploadVisit}'); // Update with the actual endpoint

    final request = http.MultipartRequest('POST', url)
      ..fields['label'] = visitDetail.label ?? ''
      ..fields['remark'] = visitDetail.remarks ?? ''
      ..fields['category'] = visitDetail.selectedCategory!.name
      ..fields['visit_lat'] = visitDetail.lat.toString()
      ..fields['visit_lng'] = visitDetail.lng.toString()
      ..fields['user_id'] = user!.userId.toString();

    for (var photoDetail in photos) {
      request.files.add(
        await http.MultipartFile.fromPath(
            'visit_photos[]', photoDetail.photo.path),
      );

      request.fields['latitude_${photos.indexOf(photoDetail)}'] =
          photoDetail.latitude.toString();
      request.fields['longitude_${photos.indexOf(photoDetail)}'] =
          photoDetail.longitude.toString();
    }

    print("Request Fields:");
    request.fields.forEach((key, value) => print("$key: $value"));

    print("\nRequest Files:");
    for (var file in request.files) {
      print("Field Name: ${file.field}");
      print("File Name: ${file.filename}");
      print("File Path: ${file.filename}");
      print("Content Type: ${file.contentType}");
    }

    final response = await request.send();
    if (response.statusCode == 200) {
      print("status  200");
      var respondingString = await response.stream.bytesToString();
      Map<String, dynamic> jsonString = convert.jsonDecode(respondingString);
      print(jsonString.toString());
      if (jsonString['status'] == 200) {
        return jsonString['message'];
      } else if (jsonString['status'] is int) {
        return Failure(jsonString['status'], jsonString['message']);
      }
    }

    // var result = await http.Response.fromStream(response);
    // print("result " + result.toString());
    // // print("response in rawhttp " + responseody.toString());
    // print("response multipart " + response.toString());
    if (response.statusCode != 200) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      // throw Exception("Failed to upload visit details");
    }
  }
}
