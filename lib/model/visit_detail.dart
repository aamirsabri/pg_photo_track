import 'package:pg_photo_track/model/request.dart';

class VisitDetail {
  String label;
  String remarks;
  Category? selectedCategory;
  double? lat;
  double? lng;

  VisitDetail(
      {required this.label,
      required this.remarks,
      this.selectedCategory,
      this.lat,
      this.lng});

  void setRemarkd(String remark) {
    remarks = remark;
  }

  void setLat(double lat) {
    this.lat = lat;
  }

  void setLng(double lng) {
    this.lng = lng;
  }

  void setLabel(String label) {
    this.label = label;
  }
}
