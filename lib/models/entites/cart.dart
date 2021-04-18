// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    this.weight,
    this.products,
    this.vouchers,
    this.couponStatus,
    this.coupon,
    this.voucherStatus,
    this.voucher,
    this.rewardStatus,
    this.reward,
    this.totals,
    this.total,
    this.totalRaw,
    this.totalProductCount,
    this.hasShipping,
    this.hasDownload,
    this.hasRecurringProducts,
    this.currency,
  });

  String weight;
  List<Product> products;
  List<dynamic> vouchers;
  String couponStatus;
  String coupon;
  String voucherStatus;
  String voucher;
  bool rewardStatus;
  String reward;
  List<Total> totals;
  String total;
  int totalRaw;
  int totalProductCount;
  int hasShipping;
  int hasDownload;
  int hasRecurringProducts;
  Currency currency;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        weight: json["weight"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        vouchers: List<dynamic>.from(json["vouchers"].map((x) => x)),
        couponStatus: json["coupon_status"],
        coupon: json["coupon"],
        voucherStatus: json["voucher_status"],
        voucher: json["voucher"],
        rewardStatus: json["reward_status"],
        reward: json["reward"].toString() ?? "",
        totals: List<Total>.from(json["totals"].map((x) => Total.fromJson(x))),
        total: json["total"],
        totalRaw: json["total_raw"],
        totalProductCount: json["total_product_count"],
        hasShipping: json["has_shipping"],
        hasDownload: json["has_download"],
        hasRecurringProducts: json["has_recurring_products"],
        currency: Currency.fromJson(json["currency"]),
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "vouchers": List<dynamic>.from(vouchers.map((x) => x)),
        "coupon_status": couponStatus,
        "coupon": coupon,
        "voucher_status": voucherStatus,
        "voucher": voucher,
        "reward_status": rewardStatus,
        "reward": reward,
        "totals": List<dynamic>.from(totals.map((x) => x.toJson())),
        "total": total,
        "total_raw": totalRaw,
        "total_product_count": totalProductCount,
        "has_shipping": hasShipping,
        "has_download": hasDownload,
        "has_recurring_products": hasRecurringProducts,
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

class Product {
  Product({
    this.key,
    this.thumb,
    this.name,
    this.points,
    this.productId,
    this.model,
    this.option,
    this.quantity,
    this.recurring,
    this.stock,
    this.reward,
    this.price,
    this.total,
    this.priceRaw,
    this.totalRaw,
  });

  String key;
  String thumb;
  String name;
  int points;
  String productId;
  String model;
  List<dynamic> option;
  String quantity;
  String recurring;
  bool stock;
  String reward;
  String price;
  String total;
  int priceRaw;
  int totalRaw;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        key: json["key"],
        thumb: json["thumb"],
        name: json["name"],
        points: json["points"],
        productId: json["product_id"],
        model: json["model"],
        option: List<dynamic>.from(json["option"].map((x) => x)),
        quantity: json["quantity"],
        recurring: json["recurring"],
        stock: json["stock"],
        reward: json["reward"],
        price: json["price"],
        total: json["total"],
        priceRaw: json["price_raw"],
        totalRaw: json["total_raw"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "thumb": thumb,
        "name": name,
        "points": points,
        "product_id": productId,
        "model": model,
        "option": List<dynamic>.from(option.map((x) => x)),
        "quantity": quantity,
        "recurring": recurring,
        "stock": stock,
        "reward": reward,
        "price": price,
        "total": total,
        "price_raw": priceRaw,
        "total_raw": totalRaw,
      };
}

class Total {
  Total({
    this.title,
    this.text,
    this.value,
  });

  String title;
  String text;
  int value;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        title: json["title"],
        text: json["text"],
        value: json["value"].toString() == "0.00" ? 0 : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "value": value,
      };
}
