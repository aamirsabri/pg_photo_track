import 'dart:ffi';

import 'package:pg_photo_track/app/constants.dart';
import 'package:pg_photo_track/model/request.dart';
import 'package:pg_photo_track/model/response.dart';
import 'package:pg_photo_track/utils/error_handling.dart';
import 'package:pg_photo_track/utils/failure.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pg_photo_track/utils/networkinfo.dart';

class AppServiceClient {
  static Future<dynamic> getRawHttp(url, argument) async {
    try {
      print("url" + url.toString());
      print("json encode " + convert.jsonEncode(argument));
      if (!await NetworkInfo.isConnected()) {
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      }
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: convert.jsonEncode(argument),
      );
      if (response.statusCode == 200) {
        print("response in rawhttp " + response.body.toString());
        final jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        print("json response" + jsonResponse.toString());
        // print("respose of url " + jsonResponse['consumer'].toString());
        return jsonResponse;
      } else {
        print(response.statusCode);
        print("when error " + response.body.toString());
        return ErrorHandler.handleError(response.statusCode);
      }
    } catch (e) {
      print("in erirr " + e.toString());
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  static Future<dynamic> login(LoginRequest loginRequest) async {
    try {
      var url = Uri.parse(Constant.baseUrl + Constant.login);
      List<Map<String, dynamic>> argument = loginRequest.toJson();
      var response = await getRawHttp(url, argument);
      if (response is Failure) {
        return response;
      }
      if (response == null) {
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      }

      if (response['Status'] == '00' || response['Status'] == '04') {
        print("code" + response['Status']);
        // print("USER " + response[JSON_OBJECT_USER].toString());
        return LoginResponse.fromJson(response);
      } else {
        return Failure(
            int.parse(response['Status']), response['Status_message']);
      }
    } catch (e) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  static Future<dynamic> sendOTP(OTPRequest otpRequest) async {
    try {
      var url = Uri.parse(Constant.baseUrl + Constant.submitotp);
      List<Map<String, dynamic>> argument = otpRequest.toJson();
      var response = await getRawHttp(url, argument);
      if (response is Failure) {
        return response;
      }
      if (response == null) {
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      }

      if (response['Status'] == '00' || response['Status'] == '01') {
        print("code" + response['Status']);
        // print("USER " + response[JSON_OBJECT_USER].toString());
        return LoginResponse.fromJson(response);
      } else {
        return Failure(
            int.parse(response['Status']), response['Status_message']);
      }
    } catch (e) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  // static dynamic checkResult(Map<String, dynamic> response) {
  //   if (response is Failure) {
  //     return response as Failure;
  //   }
  //   if (response == null) {
  //     print("check failure2");
  //     return Failure(ResponseCode.UNKNOWN, [ResponseMessage.UNKNOWN]);
  //   }
  //   if (response['success'] == true) {
  //     return response;
  //   } else {
  //     print("check failure4");
  //     return Failure(
  //         response['statusCode'] as int, List.from(response['messages']));
  //   }
  // }

  static Future<dynamic> getAllPhotoCategories() async {
    try {
      var url = Uri.parse(Constant.testBaseUrl + Constant.testGetCompanyIds);
      var response = await getRawHttp(url, null);
      if (response is Failure) {
        return response;
      }
      if (response == null) {
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      }
      if (response['status'] == 200) {
        late List<dynamic> categoryJson = response['data'];
        return categoryJson.map((json) => Category.fromJson(json)).toList();
      } else {
        if (response['status'] is int) {
          return Failure(response['status'], response['message']);
        } else {
          return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
        }
      }
    } catch (e) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }
}
