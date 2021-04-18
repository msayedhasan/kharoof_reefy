// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    this.success,
    this.error,
    this.data,
  });

  int success;
  List<dynamic> error;
  List<Datum> data;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    success: json["success"],
    error: List<dynamic>.from(json["error"].map((x) => x)),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": List<dynamic>.from(error.map((x) => x)),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.title,
    this.link,
    this.image,
  });

  String title;
  String link;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    link: json["link"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "image": image,
  };
}
