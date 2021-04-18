import 'dart:convert';

Zone zoneFromJson(String str) => Zone.fromJson(json.decode(str));

String zoneToJson(Zone data) => json.encode(data.toJson());

class Zone {
  Zone({
    this.zoneId,
    this.countryId,
    this.name,
    this.code,
    this.status,
  });

  String zoneId;
  String countryId;
  String name;
  String code;
  String status;

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        zoneId: json["zone_id"],
        countryId: json["country_id"],
        name: json["name"],
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "zone_id": zoneId,
        "country_id": countryId,
        "name": name,
        "code": code,
        "status": status,
      };
}
