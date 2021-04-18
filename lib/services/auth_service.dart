import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:kharoof_reefy/Utils/http_util.dart';
import 'package:kharoof_reefy/config.dart';

class AuthService {
  static AuthService instance = AuthService();

  Future<dynamic> login(phoneNumber) async {
    var endpoint = "rest/login/login?";
    var url = Config.API + endpoint;
    debugPrint("call login $url");
    var headers = await HttpUtils.headers();
    var _body = jsonEncode({"telephone": phoneNumber});
    var response = await post(url, headers: headers, body: _body);
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      print("Status code : " + response.statusCode.toString());
      print(response.body);
      return false;
    }
  }

  Future<bool> checkAuth() async {
    var endpoint = "feed/rest_api/checkAuth";
    var url = Config.API + endpoint;
    debugPrint("call url --> $url");
    var headers = await HttpUtils.headers();
    var response = await post(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> resendOpt(phoneNumber) async {
    var endpoint = "rest/login/resendOtp";
    var url = Config.API + endpoint;
    debugPrint("call resendOpt $url");
    var headers = await HttpUtils.headers();
    var _body = jsonEncode({"telephone": phoneNumber});
    var response = await post(url, headers: headers, body: _body);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return true;
    } else {
      print(json.decode(response.body));
      return false;
    }
  }

  Future<dynamic> confirm(code) async {
    var endpoint = "rest/login/confirmOtp";
    var url = Config.API + endpoint;
    debugPrint("call confirm $url");
    var headers = await HttpUtils.headers();
    var _body = jsonEncode({"otp": code});
    print(_body);
    var response = await post(url, headers: headers, body: _body);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return true;
    } else {
      print(json.decode(response.body));
      return false;
    }
  }

  Future<bool> logout() async {
    var endpoint = "rest/logout/logout";
    var url = Config.API + endpoint;
    debugPrint("call logout $url");
    var headers = await HttpUtils.headers();

    var response = await post(url, headers: headers);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return true;
    } else {
      print(json.decode(response.body));
      return false;
    }
  }
}
