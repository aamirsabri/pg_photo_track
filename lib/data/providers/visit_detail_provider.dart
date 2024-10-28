import 'package:flutter/material.dart';
import 'package:pg_photo_track/data/repositories/visit_repository.dart';
import 'package:pg_photo_track/model/request.dart';

class VisitDetailProvider with ChangeNotifier {
  final VisitRepository _visitRepository;

  List<Category> _categories = [];
  bool _isLoading = false;
  VisitDetail _visitDetail = VisitDetail(label: '', remarks: '');

  VisitDetailProvider() : _visitRepository = VisitRepository();

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  VisitDetail get visitDetail => _visitDetail;

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
    return _visitDetail.selectedCategory != null &&
        _visitDetail.label.isNotEmpty &&
        _visitDetail.remarks.isNotEmpty;
  }
}
