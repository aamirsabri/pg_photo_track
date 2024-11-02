import 'package:flutter/material.dart';
import 'package:pg_photo_track/app/app_pref.dart';
import 'package:pg_photo_track/model/response.dart';
import 'package:pg_photo_track/utils/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/visit_repository.dart';

class RecentVisitProvider with ChangeNotifier {
  bool isLoading = false;
  final VisitRepository _visitRepository = VisitRepository();
  List<RecentUpload> recentUploads = [];

  Future<void> loadRecentUploads() async {
    isLoading = true;
    print("load started");
    String? userId =
        await AppPreference(await SharedPreferences.getInstance()).getUserId();
    try {
      recentUploads =
          await _visitRepository.getRecentUploads(userId ?? "5300500");
      if (recentUploads is Failure) {
        recentUploads = [];
      }
      isLoading = false;
      //recentUploads = [];
      print("recent uploads result ");
      print(recentUploads.toString);
      isLoading = false;

      notifyListeners();
    } catch (e) {
      isLoading = false;
      print("Error fetching recent uploads: $e");
      notifyListeners();
    }
  }
}
