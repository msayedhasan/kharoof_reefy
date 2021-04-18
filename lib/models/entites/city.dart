import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    this.cityId,
    this.zoneId,
    this.name,
    this.status,
  });

  String cityId;
  String zoneId;
  String name;
  String status;

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"],
        zoneId: json["zone_id"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "zone_id": zoneId,
        "name": name,
        "status": status,
      };
}
