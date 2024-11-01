import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pg_photo_track/app/functions.dart';
import 'package:pg_photo_track/data/repositories/visit_repository.dart';
import 'package:pg_photo_track/domain/user.dart';
import 'package:pg_photo_track/model/photo_model.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/model/visit_detail.dart';
import 'package:pg_photo_track/utils/failure.dart';

class VisitDetailProvider with ChangeNotifier {
  String? _errorMessage;
  String? _resultMessage;
  final VisitRepository _visitRepository;
  final List<PhotoDetail> _photos = [];
  List<Category> _categories = [];
  bool _isLoading = false;
  VisitDetail _visitDetail = VisitDetail(label: '', remarks: '');

  List<PhotoDetail> get photos => List.unmodifiable(_photos);

  VisitDetailProvider() : _visitRepository = VisitRepository();
  String? get errorMessage => _errorMessage;
  String? get resultMessage => _resultMessage;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  VisitDetail get visitDetail => _visitDetail;

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

  void addPhoto(
      File photo, String? remark, double latitude, double longitude) async {
    _photos.add(
      PhotoDetail(
        photo: photo,
        date: DateTime.now(),
        remark: remark ?? '',
        latitude: latitude,
        longitude: longitude,
      ),
    );
    print("size add phto ");
    print(await photo.length());
    notifyListeners();
  }

  Future<void> submitVisitDetailsWithPhotos(UserModel user) async {
    _errorMessage = null;
    _isLoading = true;
    _resultMessage = null;

    final result = await _visitRepository.submitVisitDetailsWithPhotos(
      visitDetail: visitDetail,
      photos: _photos,
      user:user
    );
    if (result is Failure) {
      _errorMessage = result.messege;
    } else {
      _photos.clear();
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
    notifyListeners();
  }

  void setVisitLabel(String label) {
    _visitDetail.label = label;
    notifyListeners();
  }

  void setVisitRemarks(String remarks) {
    _visitDetail.remarks = remarks;
    notifyListeners();
  }

  bool isFormValid() {
    return _visitDetail.selectedCategory != null;
  }
}
