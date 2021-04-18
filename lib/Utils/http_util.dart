import 'package:kharoof_reefy/Utils/session.dart';

String tokenKey = "X-Oc-Merchant-Id";
String tokenValue = "XA4Qg75iV0QKe5ncEDc7AixAc7QeZTZq";
String sessionKey = "X-Oc-Session";
String sessionValue = "c46ef4cf6fe307956c01ce3e01";

class HttpUtils {
  static Future<Map<String, String>> headers() async {
    String sessionID = await Session.getSessionFromLocal();
    //  print("session iD : " + sessionID == null ? "null" : sessionID);
    if (sessionID == null) {
      var session = await Session.getSession();
      sessionID = session != null ? session.session : "";
    }
    return <String, String>{
      tokenKey: tokenValue,
      sessionKey: sessionID == null ? sessionValue : sessionID,
      'Content-Type': 'application/json',
      "cookie":
          "OCSESSID=$sessionID; path=/; domain=.thkapp.com; Expires=Tue, 19 Jan 2038 03:14:07 GMT;"
    };
  }
}
