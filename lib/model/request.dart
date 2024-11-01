import 'package:pg_photo_track/app/api_constants.dart';

class LoginRequest {
  String apiKey;
  String usrCode;
  String usrPass;
  String appNo;
  String imei;

  LoginRequest({
    required this.apiKey,
    required this.usrCode,
    required this.usrPass,
    required this.appNo,
    required this.imei,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      apiKey: json[ApiConstants.KEY],
      usrCode: json[ApiConstants.USER_CODE],
      usrPass: json[ApiConstants.USER_PASS],
      appNo: json[ApiConstants.APP_NO],
      imei: json[ApiConstants.IMEI],
    );
  }

  List<Map<String, dynamic>> toJson() {
    return [
      {
        ApiConstants.KEY: apiKey,
        ApiConstants.USER_CODE: usrCode,
        ApiConstants.USER_PASS: usrPass,
        ApiConstants.APP_NO: appNo,
        ApiConstants.IMEI: imei,
      }
    ];
  }
}

class OTPRequest {
  String apiKey;
  String usrCode;
  String otp;
  String appNo;
  String imei;

  OTPRequest({
    required this.apiKey,
    required this.usrCode,
    required this.otp,
    required this.appNo,
    required this.imei,
  });

  factory OTPRequest.fromJson(Map<String, dynamic> json) {
    return OTPRequest(
      apiKey: json[ApiConstants.KEY],
      usrCode: json[ApiConstants.USER_CODE],
      otp: json[ApiConstants.OTP],
      appNo: json[ApiConstants.APP_NO],
      imei: json[ApiConstants.IMEI],
    );
  }

  List<Map<String, dynamic>> toJson() {
    return [
      {
        ApiConstants.KEY: apiKey,
        ApiConstants.USER_CODE: usrCode,
        ApiConstants.OTP: otp,
        ApiConstants.APP_NO: appNo,
        ApiConstants.IMEI: imei,
      }
    ];
  }
}

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['category_id'] as String,
      name: json['category_name'] as String,
    );
  }
}
