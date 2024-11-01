import 'package:flutter/material.dart';
import 'package:pg_photo_track/app/api_constants.dart';
import 'package:pg_photo_track/app/app_pref.dart';
import 'package:pg_photo_track/domain/user.dart';
import 'package:pg_photo_track/model/response.dart';
import 'package:pg_photo_track/utils/error_handling.dart';
import 'package:pg_photo_track/utils/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/deviceinfo.dart';
import '../repositories/login_repository.dart';

class LoginProvider with ChangeNotifier {
  UserModel? _user;
  final LoginRepository _loginRepository;
  bool _isLoading = false;
  String? _errorMessage;
  bool isLoginSuccess = false;
  LoginProvider() : _loginRepository = LoginRepository();
  bool isOTPSuccess = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get user => _user;
  Future<dynamic> loginUser(String username, String password) async {
    isLoginSuccess = false;
    _isLoading = true;
    _errorMessage = null;
    // notifyListeners();
    dynamic deviceInfo = await DeviceInfo.getUniqueDeviceId();
    print('device info ' + deviceInfo.toString());
    if (deviceInfo is Failure) {
      _errorMessage = "imei number cannot be fetched";
      print('error in imei number');
      return;
    }
    try {
      final response = await _loginRepository.loginUser(
        ApiConstants.APIKEY_loginVAL,
        username,
        password,
        ApiConstants.APP_NO_VAL,
        deviceInfo.toString(),
      );

      if (response is LoginResponse) {
        if (response.status == "00") {
          isLoginSuccess = true;
        }
        print('username');
        print(response.userName);
        _user = UserModel(
            userId: username,
            password: password,
            imei: deviceInfo.toString(),
            locationName: response.locationName,
            locationCode: response.locationCode);
        AppPreference(await SharedPreferences.getInstance())
            .setUserId(username);
        AppPreference(await SharedPreferences.getInstance())
            .setPref(AppPreference.PASSWORD, password);
        AppPreference(await SharedPreferences.getInstance())
            .setPref(AppPreference.IMEI, deviceInfo.toString());

        print(
            'user ' + _user!.userId.toString() + " " + _user!.imei.toString());
      } else if (response is Failure) {
        _errorMessage = response.messege;
      }
      _isLoading = false;
      // notifyListeners();
      return response;
    } catch (e) {
      _errorMessage = "Login failed. Please try again.";
      _isLoading = false;
      // notifyListeners();
    }
  }

  Future<bool> submitOtp(String otp) async {
    _isLoading = true;
    _errorMessage = null;
    isOTPSuccess = false;
    notifyListeners();

    try {
      // Assuming submitOtp on repository verifies OTP and retu
      //rns true if valid
      print('user id ' + _user!.userId.toString());
      final result = await _loginRepository.submitOTP(
          ApiConstants.APIKEY_loginOTP,
          _user!.userId!,
          ApiConstants.APP_NO_VAL,
          _user!.imei!,
          otp);

      if (result is Failure) {
        _errorMessage = result.messege;
      }
      if (result is LoginResponse) {
        if (result.status == '00') {
          isOTPSuccess = true;
          notifyListeners();
          return true;
        }
      }
      _isLoading = false;
      notifyListeners();
      return false; // true if OTP is valid
    } catch (e) {
      _errorMessage = "OTP verification failed. Please try again.";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
