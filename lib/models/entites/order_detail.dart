import 'dart:convert';

OrderDetail orderDetailFromJson(String str) =>
    OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  OrderDetail({
    this.orderId,
    this.customerId,
    this.shippingZoneId,
    this.shippingZone,
    this.telephone,
    this.shippingZoneCode,
    this.shippingCountryId,
    this.shippingCountry,
    this.shippingDistrict,
    this.shippingDistrictId,
    this.shippingCity,
    this.shippingCityId,
    this.shippingAddressFormat,
    this.shippingMethod,
    this.comment,
    this.total,
    this.orderStatusId,
    this.languageId,
    this.currencyId,
    this.currencyCode,
    this.currencyValue,
    this.dateModified,
    this.dateAdded,
    this.shippingAddress,
    this.products,
    this.totals,
    this.shippingCost,
    this.histories,
    this.timestamp,
    this.currency,
  });

  String orderId;
  String customerId;
  String shippingZoneId;
  String shippingZone;
  String telephone;
  String shippingZoneCode;
  String shippingCountryId;
  String shippingCountry;
  String shippingDistrict;
  String shippingDistrictId;
  String shippingCity;
  String shippingCityId;
  String shippingAddressFormat;
  String shippingMethod;
  String comment;
  String total;
  String orderStatusId;
  String languageId;
  String currencyId;
  String currencyCode;
  String currencyValue;
  DateTime dateModified;
  String dateAdded;
  String shippingAddress;
  List<Product> products;
  List<ShippingCost> totals;
  ShippingCost shippingCost;
  List<History> histories;
  int timestamp;
  Currency currency;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        orderId: json["order_id"],
        customerId: json["customer_id"],
        shippingZoneId: json["shipping_zone_id"],
        shippingZone: json["shipping_zone"],
        telephone: json["telephone"],
        shippingZoneCode: json["shipping_zone_code"],
        shippingCountryId: json["shipping_country_id"],
        shippingCountry: json["shipping_country"],
        shippingDistrict: json["shipping_district"],
        shippingDistrictId: json["shipping_district_id"],
        shippingCity: json["shipping_city"],
        shippingCityId: json["shipping_city_id"],
        shippingAddressFormat: json["shipping_address_format"],
        shippingMethod: json["shipping_method"],
        comment: json["comment"],
        total: json["total"],
        orderStatusId: json["order_status_id"],
        languageId: json["language_id"],
        currencyId: json["currency_id"],
        currencyCode: json["currency_code"],
        currencyValue: json["currency_value"],
        dateModified: DateTime.parse(json["date_modified"]),
        dateAdded: json["date_added"],
        shippingAddress: json["shipping_address"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        totals: List<ShippingCost>.from(
            json["totals"].map((x) => ShippingCost.fromJson(x))),
        shippingCost: ShippingCost.fromJson(json["shippingCost"]),
        histories: List<History>.from(
            json["histories"].map((x) => History.fromJson(x))),
        timestamp: json["timestamp"],
        currency: Currency.fromJson(json["currency"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer_id": customerId,
        "shipping_zone_id": shippingZoneId,
        "shipping_zone": shippingZone,
        "telephone": telephone,
        "shipping_zone_code": shippingZoneCode,
        "shipping_country_id": shippingCountryId,
        "shipping_country": shippingCountry,
        "shipping_district": shippingDistrict,
        "shipping_district_id": shippingDistrictId,
        "shipping_city": shippingCity,
        "shipping_city_id": shippingCityId,
        "shipping_address_format": shippingAddressFormat,
        "shipping_method": shippingMethod,
        "comment": comment,
        "total": total,
        "order_status_id": orderStatusId,
        "language_id": languageId,
        "currency_id": currencyId,
        "currency_code": currencyCode,
        "currency_value": currencyValue,
        "date_modified": dateModified.toIso8601String(),
        "date_added": dateAdded,
        "shipping_address": shippingAddress,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "totals": List<dynamic>.from(totals.map((x) => x.toJson())),
        "shippingCost": shippingCost.toJson(),
        "histories": List<dynamic>.from(histories.map((x) => x.toJson())),
        "timestamp": timestamp,
        "currency": currency.toJson(),
      };
}

class Currency {
  Currency({
    this.currencyId,
    this.symbolLeft,
    this.symbolRight,
    this.decimalPlace,
    this.value,
  });

  String currencyId;
  String symbolLeft;
  String symbolRight;
  String decimalPlace;
  String value;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        currencyId: json["currency_id"],
        symbolLeft: json["symbol_left"],
        symbolRight: json["symbol_right"],
        decimalPlace: json["decimal_place"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "currency_id": currencyId,
        "symbol_left": symbolLeft,
        "symbol_right": symbolRight,
        "decimal_place": decimalPlace,
        "value": value,
      };
}

class History {
  History({
    this.dateAdded,
    this.status,
    this.comment,
  });

  String dateAdded;
  String status;
  String comment;

  factory History.fromJson(Map<String, dynamic> json) => History(
        dateAdded: json["date_added"],
        status: json["status"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "date_added": dateAdded,
        "status": status,
        "comment": comment,
      };
}

class Product {
  Product({
    this.the0,
    this.productId,
    this.orderProductId,
    this.name,
    this.model,
    this.image,
    this.option,
    this.quantity,
    this.price,
    this.total,
    this.priceRaw,
    this.totalRaw,
  });

  String the0;
  String productId;
  String orderProductId;
  String name;
  String model;
  String image;
  List<Option> option;
  String quantity;
  String price;
  String total;
  int priceRaw;
  int totalRaw;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        the0: json["0"],
        productId: json["product_id"],
        orderProductId: json["order_product_id"],
        name: json["name"],
        model: json["model"],
        image: json["image"],
        option:
            List<Option>.from(json["option"].map((x) => Option.fromJson(x))),
        quantity: json["quantity"],
        price: json["price"],
        total: json["total"],
        priceRaw: json["price_raw"],
        totalRaw: json["total_raw"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "product_id": productId,
        "order_product_id": orderProductId,
        "name": name,
        "model": model,
        "image": image,
        "option": List<dynamic>.from(option.map((x) => x.toJson())),
        "quantity": quantity,
        "price": price,
        "total": total,
        "price_raw": priceRaw,
        "total_raw": totalRaw,
      };
}

class Option {
  Option({
    this.name,
    this.value,
  });

  String name;
  String value;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

class ShippingCost {
  ShippingCost({
    this.orderTotalId,
    this.orderId,
    this.code,
    this.title,
    this.value,
    this.sortOrder,
  });

  String orderTotalId;
  String orderId;
  String code;
  String title;
  String value;
  String sortOrder;

  factory ShippingCost.fromJson(Map<String, dynamic> json) => ShippingCost(
        orderTotalId: json["order_total_id"],
        orderId: json["order_id"],
        code: json["code"],
        title: json["title"],
        value: json["value"],
        sortOrder: json["sort_order"],
      );

  Map<String, dynamic> toJson() => {
        "order_total_id": orderTotalId,
        "order_id": orderId,
        "code": code,
        "title": title,
        "value": value,
        "sort_order": sortOrder,
      };
}
