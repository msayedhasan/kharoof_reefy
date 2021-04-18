// To parse this JSON data, do
//
//     final productDetail = productDetailFromJson(jsonString);

import 'dart:convert';

ProductDetail productDetailFromJson(String str) =>
    ProductDetail.fromJson(json.decode(str));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

class ProductDetail {
  ProductDetail({
    this.id,
    this.productId,
    this.name,
    this.manufacturer,
    this.sku,
    this.model,
    this.image,
    this.images,
    this.originalImage,
    this.originalImages,
    this.priceExcludingTax,
    this.priceExcludingTaxFormated,
    this.price,
    this.priceFormated,
    this.rating,
    this.description,
    this.attributeGroups,
    this.special,
    this.specialExcludingTax,
    this.specialExcludingTaxFormated,
    this.specialFormated,
    this.specialStartDate,
    this.specialEndDate,
    this.discounts,
    this.options,
    this.minimum,
    this.metaTitle,
    this.metaDescription,
    this.metaKeyword,
    this.seoUrl,
    this.tag,
    this.upc,
    this.ean,
    this.jan,
    this.isbn,
    this.mpn,
    this.location,
    this.stockStatus,
    this.stockStatusId,
    this.manufacturerId,
    this.taxClassId,
    this.dateAvailable,
    this.weight,
    this.weightClassId,
    this.length,
    this.width,
    this.height,
    this.lengthClassId,
    this.subtract,
    this.sortOrder,
    this.status,
    this.dateAdded,
    this.dateModified,
    this.viewed,
    this.weightClass,
    this.lengthClass,
    this.shipping,
    this.reward,
    this.points,
    this.category,
    this.quantity,
    this.reviews,
    this.optionsChildNotRequired,
    this.recurrings,
  });

  int id;
  int productId;
  String name;
  dynamic manufacturer;
  String sku;
  String model;
  String image;
  List<String> images;
  String originalImage;
  List<String> originalImages;
  int priceExcludingTax;
  String priceExcludingTaxFormated;
  int price;
  String priceFormated;
  int rating;
  String description;
  List<dynamic> attributeGroups;
  int special;
  int specialExcludingTax;
  String specialExcludingTaxFormated;
  String specialFormated;
  String specialStartDate;
  String specialEndDate;
  List<dynamic> discounts;
  Map<String, Option> options;
  String minimum;
  String metaTitle;
  String metaDescription;
  String metaKeyword;
  String seoUrl;
  String tag;
  String upc;
  String ean;
  String jan;
  String isbn;
  String mpn;
  String location;
  String stockStatus;
  int stockStatusId;
  int manufacturerId;
  int taxClassId;
  DateTime dateAvailable;
  String weight;
  int weightClassId;
  String length;
  String width;
  String height;
  int lengthClassId;
  String subtract;
  String sortOrder;
  String status;
  DateTime dateAdded;
  DateTime dateModified;
  String viewed;
  String weightClass;
  String lengthClass;
  String shipping;
  dynamic reward;
  String points;
  List<dynamic> category;
  int quantity;
  Reviews reviews;
  String optionsChildNotRequired;
  List<dynamic> recurrings;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json["id"],
        productId: json["product_id"],
        name: json["name"],
        manufacturer: json["manufacturer"],
        sku: json["sku"],
        model: json["model"],
        image: json["image"],
        images: List<String>.from(json["images"].map((x) => x)),
        originalImage: json["original_image"],
        originalImages:
            List<String>.from(json["original_images"].map((x) => x)),
        priceExcludingTax: json["price_excluding_tax"],
        priceExcludingTaxFormated: json["price_excluding_tax_formated"],
        price: json["price"],
        priceFormated: json["price_formated"],
        rating: json["rating"],
        description: json["description"],
        attributeGroups:
            List<dynamic>.from(json["attribute_groups"].map((x) => x)),
        special: json["special"],
        specialExcludingTax: json["special_excluding_tax"],
        specialExcludingTaxFormated: json["special_excluding_tax_formated"],
        specialFormated: json["special_formated"],
        specialStartDate: json["special_start_date"],
        specialEndDate: json["special_end_date"],
        discounts: List<dynamic>.from(json["discounts"].map((x) => x)),
        options: Map.from(json["options"])
            .map((k, v) => MapEntry<String, Option>(k, Option.fromJson(v))),
        minimum: json["minimum"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaKeyword: json["meta_keyword"],
        seoUrl: json["seo_url"],
        tag: json["tag"],
        upc: json["upc"],
        ean: json["ean"],
        jan: json["jan"],
        isbn: json["isbn"],
        mpn: json["mpn"],
        location: json["location"],
        stockStatus: json["stock_status"],
        stockStatusId: json["stock_status_id"],
        manufacturerId: json["manufacturer_id"],
        taxClassId: json["tax_class_id"],
        dateAvailable: DateTime.parse(json["date_available"]),
        weight: json["weight"],
        weightClassId: json["weight_class_id"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        lengthClassId: json["length_class_id"],
        subtract: json["subtract"],
        sortOrder: json["sort_order"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: DateTime.parse(json["date_modified"]),
        viewed: json["viewed"],
        weightClass: json["weight_class"],
        lengthClass: json["length_class"],
        shipping: json["shipping"],
        reward: json["reward"],
        points: json["points"],
        category: List<dynamic>.from(json["category"].map((x) => x)),
        quantity: json["quantity"],
        reviews: Reviews.fromJson(json["reviews"]),
        optionsChildNotRequired: json["options_child_not_required"],
        recurrings: List<dynamic>.from(json["recurrings"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "name": name,
        "manufacturer": manufacturer,
        "sku": sku,
        "model": model,
        "image": image,
        "images": List<dynamic>.from(images.map((x) => x)),
        "original_image": originalImage,
        "original_images": List<dynamic>.from(originalImages.map((x) => x)),
        "price_excluding_tax": priceExcludingTax,
        "price_excluding_tax_formated": priceExcludingTaxFormated,
        "price": price,
        "price_formated": priceFormated,
        "rating": rating,
        "description": description,
        "attribute_groups": List<dynamic>.from(attributeGroups.map((x) => x)),
        "special": special,
        "special_excluding_tax": specialExcludingTax,
        "special_excluding_tax_formated": specialExcludingTaxFormated,
        "special_formated": specialFormated,
        "special_start_date": specialStartDate,
        "special_end_date": specialEndDate,
        "discounts": List<dynamic>.from(discounts.map((x) => x)),
        "options": Map.from(options)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "minimum": minimum,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_keyword": metaKeyword,
        "seo_url": seoUrl,
        "tag": tag,
        "upc": upc,
        "ean": ean,
        "jan": jan,
        "isbn": isbn,
        "mpn": mpn,
        "location": location,
        "stock_status": stockStatus,
        "stock_status_id": stockStatusId,
        "manufacturer_id": manufacturerId,
        "tax_class_id": taxClassId,
        "date_available":
            "${dateAvailable.year.toString().padLeft(4, '0')}-${dateAvailable.month.toString().padLeft(2, '0')}-${dateAvailable.day.toString().padLeft(2, '0')}",
        "weight": weight,
        "weight_class_id": weightClassId,
        "length": length,
        "width": width,
        "height": height,
        "length_class_id": lengthClassId,
        "subtract": subtract,
        "sort_order": sortOrder,
        "status": status,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "viewed": viewed,
        "weight_class": weightClass,
        "length_class": lengthClass,
        "shipping": shipping,
        "reward": reward,
        "points": points,
        "category": List<dynamic>.from(category.map((x) => x)),
        "quantity": quantity,
        "reviews": reviews.toJson(),
        "options_child_not_required": optionsChildNotRequired,
        "recurrings": List<dynamic>.from(recurrings.map((x) => x)),
      };
}

class Option {
  Option({
    this.productOptionId,
    this.optionValue,
    this.optionId,
    this.name,
    this.type,
    this.value,
    this.required,
    this.relatedOptions,
  });

  int productOptionId;
  List<OptionOptionValue> optionValue;
  int optionId;
  String name;
  String type;
  String value;
  String required;
  List<RelatedOption> relatedOptions;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        productOptionId: json["product_option_id"],
        optionValue: json["option_value"] == null
            ? null
            : List<OptionOptionValue>.from(
                json["option_value"].map((x) => OptionOptionValue.fromJson(x))),
        optionId: json["option_id"],
        name: json["name"],
        type: json["type"],
        value: json["value"],
        required: json["required"],
        relatedOptions: json["related_options"] == null
            ? null
            : List<RelatedOption>.from(
                json["related_options"].map((x) => RelatedOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_option_id": productOptionId,
        "option_value": List<dynamic>.from(optionValue.map((x) => x.toJson())),
        "option_id": optionId,
        "name": name,
        "type": type,
        "value": value,
        "required": required,
        "related_options": relatedOptions == null
            ? null
            : List<dynamic>.from(relatedOptions.map((x) => x.toJson())),
      };
}

class OptionOptionValue {
  OptionOptionValue({
    this.image,
    this.price,
    this.priceFormated,
    this.priceExcludingTax,
    this.priceExcludingTaxFormated,
    this.pricePrefix,
    this.productOptionValueId,
    this.optionValueId,
    this.name,
    this.quantity,
  });

  dynamic image;
  dynamic price;
  String priceFormated;
  int priceExcludingTax;
  String priceExcludingTaxFormated;
  String pricePrefix;
  int productOptionValueId;
  int optionValueId;
  String name;
  int quantity;

  factory OptionOptionValue.fromJson(Map<String, dynamic> json) =>
      OptionOptionValue(
        image: json["image"],
        price: json["price"],
        priceFormated: json["price_formated"],
        priceExcludingTax: json["price_excluding_tax"],
        priceExcludingTaxFormated: json["price_excluding_tax_formated"],
        pricePrefix: json["price_prefix"],
        productOptionValueId: json["product_option_value_id"],
        optionValueId: json["option_value_id"],
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "price": price,
        "price_formated": priceFormated,
        "price_excluding_tax": priceExcludingTax,
        "price_excluding_tax_formated": priceExcludingTaxFormated,
        "price_prefix": pricePrefix,
        "product_option_value_id": productOptionValueId,
        "option_value_id": optionValueId,
        "name": name,
        "quantity": quantity,
      };
}

class RelatedOption {
  RelatedOption({
    this.productOptionId,
    this.optionValue,
    this.optionId,
    this.name,
    this.type,
    this.value,
    this.required,
  });

  int productOptionId;
  List<RelatedOptionOptionValue> optionValue;
  int optionId;
  String name;
  String type;
  String value;
  String required;

  factory RelatedOption.fromJson(Map<String, dynamic> json) => RelatedOption(
        productOptionId: json["product_option_id"],
        optionValue: List<RelatedOptionOptionValue>.from(json["option_value"]
            .map((x) => RelatedOptionOptionValue.fromJson(x))),
        optionId: json["option_id"],
        name: json["name"],
        type: json["type"],
        value: json["value"],
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
        "product_option_id": productOptionId,
        "option_value": List<dynamic>.from(optionValue.map((x) => x.toJson())),
        "option_id": optionId,
        "name": name,
        "type": type,
        "value": value,
        "required": required,
      };
}

class RelatedOptionOptionValue {
  RelatedOptionOptionValue({
    this.image,
    this.price,
    this.priceFormated,
    this.priceExcludingTax,
    this.priceExcludingTaxFormated,
    this.pricePrefix,
    this.productOptionValueId,
    this.optionValueId,
    this.name,
    this.quantity,
    this.flage,
  });

  dynamic image;
  dynamic price;
  String priceFormated;
  int priceExcludingTax;
  String priceExcludingTaxFormated;
  String pricePrefix;
  int productOptionValueId;
  int optionValueId;
  String name;
  int quantity;
  String flage;

  factory RelatedOptionOptionValue.fromJson(Map<String, dynamic> json) =>
      RelatedOptionOptionValue(
        image: json["image"],
        price: json["price"],
        priceFormated: json["price_formated"],
        priceExcludingTax: json["price_excluding_tax"],
        priceExcludingTaxFormated: json["price_excluding_tax_formated"],
        pricePrefix: json["price_prefix"],
        productOptionValueId: json["product_option_value_id"],
        optionValueId: json["option_value_id"],
        name: json["name"],
        quantity: json["quantity"],
        flage: json["flage"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "price": price,
        "price_formated": priceFormated,
        "price_excluding_tax": priceExcludingTax,
        "price_excluding_tax_formated": priceExcludingTaxFormated,
        "price_prefix": pricePrefix,
        "product_option_value_id": productOptionValueId,
        "option_value_id": optionValueId,
        "name": name,
        "quantity": quantity,
        "flage": flage,
      };
}

class Reviews {
  Reviews({
    this.reviewTotal,
  });

  String reviewTotal;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        reviewTotal: json["review_total"],
      );

  Map<String, dynamic> toJson() => {
        "review_total": reviewTotal,
      };
}
