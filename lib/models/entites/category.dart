import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.categoryId,
    this.parentId,
    this.name,
    this.seoUrl,
    this.image,
    this.price,
    this.originalImage,
    this.filters,
    this.categories,
  });

  int categoryId;
  int parentId;
  String name;
  String seoUrl;
  String image;
  String price;
  String originalImage;
  Filters filters;
  List<Category> categories;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        parentId: json["parent_id"],
        name: json["name"],
        seoUrl: json["seo_url"],
        image: json["image"],
        price: json["price"],
        originalImage: json["original_image"],
        filters: Filters.fromJson(json["filters"]),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "parent_id": parentId,
        "name": name,
        "seo_url": seoUrl,
        "image": image,
        "price": price,
        "original_image": originalImage,
        "filters": filters.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x)),
      };
}

class Filters {
  Filters({
    this.filterGroups,
  });

  List<dynamic> filterGroups;

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        filterGroups: List<dynamic>.from(json["filter_groups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "filter_groups": List<dynamic>.from(filterGroups.map((x) => x)),
      };
}
