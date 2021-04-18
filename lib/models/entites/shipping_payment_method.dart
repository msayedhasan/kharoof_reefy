// To parse this JSON data, do
//
//     final sippingAndPaymentMethed = sippingAndPaymentMethedFromJson(jsonString);

import 'dart:convert';

ShippingAndPaymentMethed sippingAndPaymentMethedFromJson(String str) =>
    ShippingAndPaymentMethed.fromJson(json.decode(str));

String sippingAndPaymentMethedToJson(ShippingAndPaymentMethed data) =>
    json.encode(data.toJson());

class ShippingAndPaymentMethed {
  ShippingAndPaymentMethed({
    this.paymentMethods,
    this.shippingMethods,
    this.code,
    this.comment,
  });

  List<PaymentMethod> paymentMethods;
  List<ShippingMethod> shippingMethods;
  String code;
  String comment;

  factory ShippingAndPaymentMethed.fromJson(Map<String, dynamic> json) =>
      ShippingAndPaymentMethed(
        paymentMethods: List<PaymentMethod>.from(
            json["payment_methods"].map((x) => PaymentMethod.fromJson(x))),
        shippingMethods: List<ShippingMethod>.from(
            json["shipping_methods"].map((x) => ShippingMethod.fromJson(x))),
        code: json["code"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "payment_methods":
            List<dynamic>.from(paymentMethods.map((x) => x.toJson())),
        "shipping_methods":
            List<dynamic>.from(shippingMethods.map((x) => x.toJson())),
        "code": code,
        "comment": comment,
      };
}

class PaymentMethod {
  PaymentMethod({
    this.code,
    this.title,
    this.terms,
    this.sortOrder,
  });

  String code;
  String title;
  String terms;
  String sortOrder;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        code: json["code"],
        title: json["title"],
        terms: json["terms"],
        sortOrder: json["sort_order"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "terms": terms,
        "sort_order": sortOrder,
      };
}

class ShippingMethod {
  ShippingMethod({
    this.title,
    this.quote,
    this.sortOrder,
    this.error,
  });

  String title;
  List<Quote> quote;
  String sortOrder;
  bool error;

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
        title: json["title"],
        quote: List<Quote>.from(json["quote"].map((x) => Quote.fromJson(x))),
        sortOrder: json["sort_order"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "quote": List<dynamic>.from(quote.map((x) => x.toJson())),
        "sort_order": sortOrder,
        "error": error,
      };
}

class Quote {
  Quote({
    this.code,
    this.title,
    this.cost,
    this.taxClassId,
    this.text,
  });

  String code;
  String title;
  String cost;
  String taxClassId;
  String text;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        code: json["code"],
        title: json["title"],
        cost: json["cost"],
        taxClassId: json["tax_class_id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "cost": cost,
        "tax_class_id": taxClassId,
        "text": text,
      };
}
