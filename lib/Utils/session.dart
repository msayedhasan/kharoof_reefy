import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kharoof_reefy/config.dart';
import 'package:kharoof_reefy/consts/api_consts.dart';
import 'package:kharoof_reefy/models/entites/session.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<SessionData> getSession() async {
    var url = Config.API + "feed/rest_api/session";
    debugPrint("http call =========> $url");

    var response = await get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'X-Oc-Merchant-Id': tokenValue,
    });
    if (response.statusCode == 200) {
      return SessionData.fromJson(json.decode(response.body)['data']);
    } else {
      print(json.decode(response.body));
      return null;
    }
  }

  static setSessionLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var session = await getSession();
    if (session != null) {
      print(session.session + " stored session id");
      await prefs.setString("session", session.session);
    } else {
      print("session null");
    }
  }

  static removeSessionLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("session", null);
  }

  static Future<String> getSessionFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sid = prefs.getString("session");
    print('getSessionFromLocal');
    return sid;
  }

  static Future<bool> checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sid = prefs.getString("session");
    if (sid == null) {
      return false;
    } else {
      return true;
    }
  }
}
