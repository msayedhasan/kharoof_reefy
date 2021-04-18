class MyOrder {
  MyOrder({
    this.orderId,
    this.name,
    this.status,
    this.dateAdded,
    this.products,
    this.total,
    this.currencyCode,
    this.currencyValue,
    this.totalRaw,
    this.timestamp,
    this.currency,
  });

  String orderId;
  String name;
  String status;
  String dateAdded;
  int products;
  String total;
  String currencyCode;
  String currencyValue;
  String totalRaw;
  int timestamp;
  Currency currency;

  factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
        orderId: json["order_id"],
        name: json["name"],
        status: json["status"],
        dateAdded: json["date_added"],
        products: json["products"],
        total: json["total"],
        currencyCode: json["currency_code"],
        currencyValue: json["currency_value"],
        totalRaw: json["total_raw"],
        timestamp: json["timestamp"],
        currency: Currency.fromJson(json["currency"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "name": name,
        "status": status,
        "date_added": dateAdded,
        "products": products,
        "total": total,
        "currency_code": currencyCode,
        "currency_value": currencyValue,
        "total_raw": totalRaw,
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
