import 'dart:convert';

SessionData sessionDataFromJson(String str) =>
    SessionData.fromJson(json.decode(str));

String sessionDataToJson(SessionData data) => json.encode(data.toJson());

class SessionData {
  SessionData({
    this.session,
  });

  String session;

  factory SessionData.fromJson(Map<String, dynamic> json) => SessionData(
        session: json["session"],
      );

  Map<String, dynamic> toJson() => {
        "session": session,
      };
}
