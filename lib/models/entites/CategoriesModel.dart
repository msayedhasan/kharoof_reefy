// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    this.value,
    this.key,
    this.data,
  });

  int value;
  String key;
  Data data;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    value: json["value"],
    key: json["key"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "key": key,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.slider,
    this.taps,
    this.animals,
    this.news,
    this.workArea,
  });

  List<Slider> slider;
  List<Tap> taps;
  List<Animal> animals;
  List<Animal> news;
  String workArea;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    slider: List<Slider>.from(json["slider"].map((x) => Slider.fromJson(x))),
    taps: List<Tap>.from(json["taps"].map((x) => Tap.fromJson(x))),
    animals: List<Animal>.from(json["animals"].map((x) => Animal.fromJson(x))),
    news: List<Animal>.from(json["news"].map((x) => Animal.fromJson(x))),
    workArea: json["work_area"],
  );

  Map<String, dynamic> toJson() => {
    "slider": List<dynamic>.from(slider.map((x) => x.toJson())),
    "taps": List<dynamic>.from(taps.map((x) => x.toJson())),
    "animals": List<dynamic>.from(animals.map((x) => x.toJson())),
    "news": List<dynamic>.from(news.map((x) => x.toJson())),
    "work_area": workArea,
  };
}

class Animal {
  Animal({
    this.id,
    this.image,
    this.name,
    this.desc,
    this.price,
    this.phone,
  });

  int id;
  String image;
  String name;
  String desc;
  int price;
  String phone;

  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    desc: json["desc"],
    price: json["price"] == null ? null : json["price"],
    phone: json["phone"] == null ? null : json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "desc": desc,
    "price": price == null ? null : price,
    "phone": phone == null ? null : phone,
  };
}

class Slider {
  Slider({
    this.id,
    this.image,
    this.link,
  });

  int id;
  String image;
  String link;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    id: json["id"],
    image: json["image"],
    link: json["link"] == null ? null : json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "link": link == null ? null : link,
  };
}

class Tap {
  Tap({
    this.id,
    this.desc,
  });

  int id;
  String desc;

  factory Tap.fromJson(Map<String, dynamic> json) => Tap(
    id: json["id"],
    desc: json["desc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "desc": desc,
  };
}
