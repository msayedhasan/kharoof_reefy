import 'dart:convert';

District districtFromJson(String str) => District.fromJson(json.decode(str));

String districtToJson(District data) => json.encode(data.toJson());

class District {
  District({
    this.districtId,
    this.cityId,
    this.name,
    this.status,
  });

  String districtId;
  String cityId;
  String name;
  String status;

  factory District.fromJson(Map<String, dynamic> json) => District(
        districtId: json["district_id"],
        cityId: json["city_id"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "city_id": cityId,
        "name": name,
        "status": status,
      };
}
