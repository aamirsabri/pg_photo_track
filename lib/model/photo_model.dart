import 'dart:io';

class PhotoDetail {
  File photo;
  String remark;
  DateTime date;
  double? latitude;
  double? longitude;

  PhotoDetail({
    required this.photo,
    required this.remark,
    required this.date,
    required this.latitude,
    required this.longitude,
  });
}
