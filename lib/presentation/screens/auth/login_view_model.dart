import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/utils/deviceinfo.dart';
import 'package:pg_photo_track/utils/failure.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModelController {
  BuildContext context;
  LoginViewModelController(this.context);
  Future<dynamic?> login(String empId, String password) async {
    EasyLoading.show();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    print("version " + version.toLowerCase());
    dynamic deviceInfo = await DeviceInfo.getUniqueDeviceId();
    print(deviceInfo);
    if (deviceInfo is Failure) {
      return deviceInfo;
    } else {
      print("device info " + deviceInfo.toString());
    }
    // var result = await AppServiceClient.login(LoginRequest(
    //     companyId: companyId,
    //     empId: empId.toLowerCase(),
    //     password: password,
    //     imei: deviceInfo.toString(),
    //     version: version.toString()));
    // print("result " + result.toString());
    // if (result is User) {
    //   Provider.of<UserDetailProvider>(context, listen: false)
    //       .updateUser(result);
    //   SharedPreferences sharedPreferences =
    //       await SharedPreferences.getInstance();
    //   AppPreference appPreference = AppPreference(sharedPreferences);
    //   appPreference.setPref(AppPreference.USER_ID, empId);
    //   appPreference.setPref(AppPreference.PASSWORD, password);
    //   sharedPreferences.setInt(AppPreference.COMPANY_ID, companyId);

    //   return result;
    // } else {
    //   return result;
    // }
  }

  Future<dynamic> autoLogin() async {
    // try {
    //   EasyLoading.show();
    //   SharedPreferences sharedPreferences =
    //       await SharedPreferences.getInstance();
    //   String? empId = await sharedPreferences.getString(AppPreference.USER_ID);
    //   String? password =
    //       await sharedPreferences.getString(AppPreference.PASSWORD);
    //   int? companyId = await sharedPreferences.getInt(AppPreference.COMPANY_ID);
    //   if (empId == null || password == null || companyId == null) {
    //     return "fail";
    //   }

    //   return await login(companyId, empId, password);
    // } catch (e) {
    //   return "fail";
    // }
  }

  bool isAdminUser(String userType) {
    print(userType.substring(
      userType.length - 3,
    ));
    if (userType.substring(userType.length - 3) == "ADM") {
      return true;
    }
    return false;
  }

  Future<dynamic> _fetchData() async {
    // var result = await AppServiceClient.getAllCompanyMaster();
    // return result;
  }
}
