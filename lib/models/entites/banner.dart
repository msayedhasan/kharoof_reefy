import 'dart:convert';

BannerModel BannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String BannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    this.title,
    this.link,
    this.image,
  });

  String title;
  String link;
  String image;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
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
