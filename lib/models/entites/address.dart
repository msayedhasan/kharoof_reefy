import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.addressId,
    this.name,
    this.telephone,
    this.position,
    this.nearestPoint,
    this.districtId,
    this.district,
    this.cityId,
    this.city,
    this.zoneId,
    this.zone,
    this.zoneCode,
    this.countryId,
    this.country,
    this.isoCode2,
    this.isoCode3,
    this.addressFormat,
    this.customField,
    this.addressDefault,
  });

  String addressId;
  dynamic name;
  String telephone;
  String position;
  String nearestPoint;
  String districtId;
  String district;
  String cityId;
  String city;
  String zoneId;
  String zone;
  String zoneCode;
  String countryId;
  String country;
  String isoCode2;
  String isoCode3;
  String addressFormat;
  dynamic customField;
  bool addressDefault;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressId: json["address_id"],
        name: json["name"],
        telephone: json["telephone"],
        position: json["position"],
        nearestPoint: json["nearest_point"],
        districtId: json["district_id"],
        district: json["district"],
        cityId: json["city_id"],
        city: json["city"],
        zoneId: json["zone_id"],
        zone: json["zone"],
        zoneCode: json["zone_code"],
        countryId: json["country_id"],
        country: json["country"],
        isoCode2: json["iso_code_2"],
        isoCode3: json["iso_code_3"],
        addressFormat: json["address_format"],
        customField: json["custom_field"],
        addressDefault: json["default"],
      );

  Map<String, dynamic> toJson() => {
        "address_id": addressId,
        "name": name,
        "telephone": telephone,
        "position": position,
        "nearest_point": nearestPoint,
        "district_id": districtId,
        "district": district,
        "city_id": cityId,
        "city": city,
        "zone_id": zoneId,
        "zone": zone,
        "zone_code": zoneCode,
        "country_id": countryId,
        "country": country,
        "iso_code_2": isoCode2,
        "iso_code_3": isoCode3,
        "address_format": addressFormat,
        "custom_field": customField,
        "default": addressDefault,
      };
}
