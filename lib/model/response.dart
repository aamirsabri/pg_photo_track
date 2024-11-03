import 'dart:ffi';

import 'package:pg_photo_track/app/functions.dart';

class LoginResponse {
  final String status;
  final String statusMessage;
  final String? userName;
  final String? locationName;
  final String? locationCode;

  LoginResponse(
      {required this.status,
      required this.statusMessage,
      this.userName,
      this.locationName,
      this.locationCode});

  Map<String, dynamic> toJson() {
    return ({
      "Status": status.toString(),
      "Status_message": statusMessage,
      "User_name": userName,
      "Location_name": locationName,
      "Location_code": locationCode,
    });
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['Status'],
      statusMessage: json['Status_message'],
      userName: json['User_name'],
      locationName: json['Location_name'],
      locationCode: json['Location_code'],
    );
  }
}

class RecentUpload {
  final int visitId;
  String? visitUniqueIdentifier;
  final String visitCategory;
  final String date;
  String? remark;
  double? visitLat;
  double? visitLng;
  int? totalUploadedPhotos;

  RecentUpload(
      {required this.visitId,
      required this.visitUniqueIdentifier,
      required this.visitCategory,
      required this.date,
      required this.remark,
      this.visitLat,
      this.visitLng,
      this.totalUploadedPhotos});

  factory RecentUpload.fromJson(Map<String, dynamic> json) {
    print("visit id " + int.parse(json['visit_id']).toString());
    return RecentUpload(
      visitId: int.parse(json['visit_id'].toString()),
      visitUniqueIdentifier: json['visit_unique_identifier'].toString(),
      visitCategory: json['visit_category'],
      date: json['visit_date'],
      remark: json['remark'],
      visitLat: json.containsKey('latitude')
          ? convertJsonStringToDouble(json['latitude'])
          : null,
      visitLng: json.containsKey('longitude')
          ? convertJsonStringToDouble(json['longitude'])
          : null,
      totalUploadedPhotos: json.containsKey('no_of_photos')
          ? int.parse(json['no_of_photos'].toString())
          : null,
    );
  }
}
