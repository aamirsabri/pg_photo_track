import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pg_photo_track/app/functions.dart';
import 'package:pg_photo_track/data/repositories/visit_repository.dart';
import 'package:pg_photo_track/domain/mylocation.dart';
import 'package:pg_photo_track/domain/user.dart';
import 'package:pg_photo_track/model/photo_model.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/model/visit_detail.dart';
import 'package:pg_photo_track/utils/failure.dart';
import 'package:pg_photo_track/utils/locationinfo.dart';

class VisitDetailProvider with ChangeNotifier {
  String? _errorMessage;
  String? _resultMessage;
  final VisitRepository _visitRepository;
  List<PhotoDetail> _photos = [];
  List<Category> _categories = [];
  bool _isLoading = false;
  VisitDetail _visitDetail = VisitDetail(label: '', remarks: '');
  MyLocation? myLocation;
  List<PhotoDetail> get photos => List.from(_photos);
  Category? defaultCategory;

  VisitDetailProvider() : _visitRepository = VisitRepository();
  String? get errorMessage => _errorMessage;
  String? get resultMessage => _resultMessage;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  VisitDetail get visitDetail => _visitDetail;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void deletePhoto(PhotoDetail photoDetail) {
    int index = 0;
    for (PhotoDetail photo in _photos) {
      if (photo == photoDetail) {
        _photos.removeAt(index);
        notifyListeners();
        return;
      }
      index = index + 1;
    }
  }

  Future<void> updateLocation() async {
    myLocation = await LocationInfo.getUserLocation();
    notifyListeners();
  }

  void addPhoto(
      File photo, String? remark, double? latitude, double? longitude) async {
    print("my location " + myLocation!.latitude.toString());
    _photos.clear();
    _photos.add(
      PhotoDetail(
          photo: photo,
          date: DateTime.now(),
          remark: remark ?? '',
          latitude: myLocation?.latitude,
          longitude: myLocation?.longitude,
          category: defaultCategory),
    );

    // _photos[0] = PhotoDetail(
    //     photo: photo,
    //     date: DateTime.now(),
    //     remark: remark ?? '',
    //     latitude: myLocation?.latitude,
    //     longitude: myLocation?.longitude,
    //     category: defaultCategory);

    print(await photo.length());
    notifyListeners();
  }

  Future<void> submitVisitDetailsWithPhotos(UserModel? user) async {
    _errorMessage = null;
    _isLoading = true;
    _resultMessage = null;
    print("in sumit visit");
    visitDetail.locationDetail?.setFullAddress();

    final result = await _visitRepository.submitVisitDetailsWithPhotos(
      visitDetail: visitDetail,
      photos: _photos,
      user: user,
    );
    if (result is Failure) {
      _errorMessage = result.messege;
    } else {
      _photos.clear();
      visitDetail.selectedCategory = null;
      defaultCategory = null;
      visitDetail.label = '';
      _resultMessage = result;
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await _visitRepository.getCategories();
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setVisitCategory(Category? category) {
    _visitDetail.selectedCategory = category;
    defaultCategory = null;
    notifyListeners();
  }

  void setVisitLabel(String label) {
    _visitDetail.label = label;
    notifyListeners();
  }

  void setDefaultCategory(Category? category) {
    defaultCategory = category;
    notifyListeners();
  }

  void setVisitRemarks(String remarks) {
    _visitDetail.remarks = remarks;
    notifyListeners();
  }

  bool isFormValid() {
    return defaultCategory != null;
  }
}
