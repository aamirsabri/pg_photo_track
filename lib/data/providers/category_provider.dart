import 'package:flutter/material.dart';
import 'package:pg_photo_track/data/repositories/visit_repository.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/utils/failure.dart';

class CategoryProvider with ChangeNotifier {
  final VisitRepository _visitRepository;
  List<Category> _categories = [];
  Category? _selectedCategory;
  bool _isLoading = false;
  String? _errorMessage;

  CategoryProvider() : _visitRepository = VisitRepository();

  List<Category> get categories => _categories;
  Category? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  // void setVisitProvider(VisitRepository visitRepository){
  //   visitRepository =
  // }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _visitRepository.getCategories();
      if (response is Failure) {
        _errorMessage = response.messege;
      }
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(Category? category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
