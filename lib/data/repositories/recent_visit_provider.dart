import 'package:flutter/material.dart';
import 'package:pg_photo_track/app/app_pref.dart';
import 'package:pg_photo_track/model/response.dart';
import 'package:pg_photo_track/utils/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/visit_repository.dart';

class RecentVisitProvider with ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  bool hasError = false;

  final VisitRepository _visitRepository = VisitRepository();
  List<RecentUpload> recentUploads = [];

  Future<dynamic> loadRecentUploads() async {
    recentUploads = [];
    isLoading = true;
    errorMessage = null;
    hasError = false;
    notifyListeners();
    print("load started");
    String? userId =
        await AppPreference(await SharedPreferences.getInstance()).getUserId();
    try {
      final result =
          await _visitRepository.getRecentUploads(userId ?? "5300500");

      if (result is Failure) {
        errorMessage = result.messege;
        hasError = true;
      } else {
        recentUploads = result;
      }
      isLoading = false;
      //recentUploads = [];
      print("recent uploads result ");
      print(recentUploads.toString);

      notifyListeners();
    } catch (e) {
      isLoading = false;
      hasError = true;
      print("Error fetching recent uploads: $e");
      notifyListeners();
    }
  }

  Future<dynamic> fetchRecentPhoto(int visitId) async {
    isLoading = true;
    errorMessage = null;
    hasError = false;
    // notifyListeners();
    print("visit it  " + visitId.toString());
    try {
      final result = await _visitRepository.getImageFromVisitId(visitId);
      print("resutl " + result.toString());
      isLoading = false;
      return result;
    } catch (e) {
      isLoading = false;
      hasError = true;
      print("Error fetching recent uploads: $e");
      notifyListeners();
    }
  }
}
