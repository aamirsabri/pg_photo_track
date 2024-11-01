import 'package:flutter/material.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/presentation/screens/auth/login.dart';
import 'package:pg_photo_track/presentation/screens/auth/otp_screen.dart';
import 'package:pg_photo_track/presentation/screens/capture_review_photos/capture_review_photos.dart';
import 'package:pg_photo_track/presentation/screens/home_screen.dart';
import 'package:pg_photo_track/presentation/screens/photos_capture_upload/capture_photo_screen.dart';
import 'package:pg_photo_track/presentation/screens/visit/review_submit_screen.dart';
import 'package:pg_photo_track/presentation/screens/visit/select_visit_category.dart';
import 'package:pg_photo_track/presentation/screens/visit/visit_detail_screen.dart';

import 'color_manager.dart';

import 'style_manager.dart';

class Routes {
  static const String loginRoute = "/login";
  static const String homeRoute = "/home";
  static const String otpRoute = "/otp";
  static const String mainRoute = "/";
  static const String testRoute = "/test";
  static const String selectCategory = "/cat";
  static const String visetDetail = "/visitDetail";
  static const String reviewPhotos = "/reviewPhotos";
  static const String capturePhoto = "/capturePhotoScreen";
  static const String reviewSubmit = "/submit";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        {
          return MaterialPageRoute(builder: (_) => HomeScreen());
        }
      case Routes.loginRoute:
        {
          return MaterialPageRoute(builder: (_) => LoginScreen());
        }
      case Routes.otpRoute:
        {
          return MaterialPageRoute(builder: (_) => OtpScreen());
        }
      case Routes.selectCategory:
        {
          return MaterialPageRoute(builder: (_) => SelectVisitCategoryScreen());
        }
      case Routes.visetDetail:
        {
          return MaterialPageRoute(builder: (_) => VisitDetailScreen());
        }
      case Routes.capturePhoto:
        {
          return MaterialPageRoute(builder: (_) => CapturePhotoScreen());
        }
      case Routes.reviewPhotos:
        {
          return MaterialPageRoute(builder: (_) => CaptureReviewPhotos());
        }
      case Routes.reviewSubmit:
        {
          return MaterialPageRoute(builder: (_) => ReviewAndSubmitScreen());
        }

      default:
        return unDefinedRoute();
      // exit(0);
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                  child: Text(
                "NO Route Found",
                style: getBoldStyle(fontColor: ColorManager.darkgrey),
              )),
            ));
  }
}
