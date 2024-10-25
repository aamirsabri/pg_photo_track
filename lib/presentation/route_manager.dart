import 'package:flutter/material.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/presentation/screens/auth/login.dart';
import 'package:pg_photo_track/presentation/screens/home_screen.dart';

import 'color_manager.dart';

import 'style_manager.dart';

class Routes {
  static const String loginRoute = "/login";
  static const String homeRoute = "/home";
  static const String otpRoute = "/otp";
  static const String mainRoute = "/";
  static const String testRoute = "/test";
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
