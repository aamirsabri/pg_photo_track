import 'dart:io';

import 'package:pg_photo_track/model/request.dart';

class PhotoDetail {
  File photo;
  String remark;
  DateTime date;
  double? latitude;
  double? longitude;
  Category? category;

  PhotoDetail({
    required this.photo,
    required this.remark,
    required this.date,
    required this.latitude,
    required this.longitude,
    this.category,
  });
}
