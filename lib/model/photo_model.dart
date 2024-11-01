import 'dart:io';

class PhotoDetail {
  final File photo;
  final String remark;
  final DateTime date;
  final double latitude;
  final double longitude;

  PhotoDetail({
    required this.photo,
    required this.remark,
    required this.date,
    required this.latitude,
    required this.longitude,
  });
}
