// data/repository/login_repository.dart

import 'package:pg_photo_track/app/apis.dart';
import 'package:pg_photo_track/domain/user.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/model/response.dart';
import 'package:pg_photo_track/utils/failure.dart';

class LoginRepository {
  Future<dynamic> loginUser(String apiKey, String usrCode, String usrPass,
      String appNo, String imei) async {
    final request = LoginRequest(
      apiKey: apiKey,
      usrCode: usrCode,
      usrPass: usrPass,
      appNo: appNo,
      imei: imei,
    );

    final response = await AppServiceClient.login(request);
    return response;
    // return UserModel(
    //     userId: loginResponse.userName,
    //     password: usrPass,
    //     imei: imei,
    //     locationName: loginResponse.locationName,
    //     locationCode: loginResponse.locationCode);
  }

  Future<dynamic> submitOTP(String apiKey, String usrCode, String appNo,
      String imei, String otp) async {
    OTPRequest otpRequest = OTPRequest(
        apiKey: apiKey, usrCode: usrCode, otp: otp, appNo: appNo, imei: imei);
    return await AppServiceClient.sendOTP(otpRequest);
  }
}
