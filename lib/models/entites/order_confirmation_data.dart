import 'dart:convert';

OrderConfirmationData OrderConfirmationDataFromJson(String str) =>
    OrderConfirmationData.fromJson(json.decode(str));

String OrderConfirmationDataToJson(OrderConfirmationData data) =>
    json.encode(data.toJson());

class OrderConfirmationData {
  OrderConfirmationData({
    this.totals,
    this.invoicePrefix,
    this.storeId,
    this.storeName,
    this.storeUrl,
    this.customerId,
    this.customerGroupId,
    this.telephone,
    this.customField,
    this.paymentDistrictId,
    this.paymentCityId,
    this.paymentZone,
    this.paymentZoneId,
    this.paymentCountry,
    this.paymentCountryId,
    this.paymentAddressFormat,
    this.paymentCustomField,
    this.paymentMethod,
    this.paymentCode,
    this.shippingDistrictId,
    this.shippingCityId,
    this.shippingZone,
    this.shippingZoneId,
    this.shippingCountry,
    this.shippingCountryId,
    this.shippingAddressFormat,
    this.shippingCustomField,
    this.shippingMethod,
    this.shippingCode,
    this.products,
    this.vouchers,
    this.comment,
    this.total,
    this.affiliateId,
    this.commission,
    this.marketingId,
    this.tracking,
    this.languageId,
    this.currencyId,
    this.currencyCode,
    this.currencyValue,
    this.ip,
    this.forwardedIp,
    this.userAgent,
    this.acceptLanguage,
    this.orderId,
    this.payment,
  });

  List<Total> totals;
  String invoicePrefix;
  int storeId;
  String storeName;
  String storeUrl;
  String customerId;
  String customerGroupId;
  String telephone;
  dynamic customField;
  String paymentDistrictId;
  String paymentCityId;
  String paymentZone;
  String paymentZoneId;
  String paymentCountry;
  String paymentCountryId;
  String paymentAddressFormat;
  dynamic paymentCustomField;
  String paymentMethod;
  String paymentCode;
  String shippingDistrictId;
  String shippingCityId;
  String shippingZone;
  String shippingZoneId;
  String shippingCountry;
  String shippingCountryId;
  String shippingAddressFormat;
  List<dynamic> shippingCustomField;
  String shippingMethod;
  String shippingCode;
  List<Product> products;
  List<dynamic> vouchers;
  String comment;
  int total;
  int affiliateId;
  int commission;
  int marketingId;
  String tracking;
  String languageId;
  String currencyId;
  String currencyCode;
  String currencyValue;
  String ip;
  String forwardedIp;
  String userAgent;
  String acceptLanguage;
  String orderId;
  String payment;

  factory OrderConfirmationData.fromJson(Map<String, dynamic> json) =>
      OrderConfirmationData(
        totals: List<Total>.from(json["totals"].map((x) => Total.fromJson(x))),
        invoicePrefix: json["invoice_prefix"],
        storeId: json["store_id"],
        storeName: json["store_name"],
        storeUrl: json["store_url"],
        customerId: json["customer_id"],
        customerGroupId: json["customer_group_id"],
        telephone: json["telephone"],
        customField: json["custom_field"],
        paymentDistrictId: json["payment_district_id"],
        paymentCityId: json["payment_city_id"],
        paymentZone: json["payment_zone"],
        paymentZoneId: json["payment_zone_id"],
        paymentCountry: json["payment_country"],
        paymentCountryId: json["payment_country_id"],
        paymentAddressFormat: json["payment_address_format"],
        paymentCustomField: json["payment_custom_field"],
        paymentMethod: json["payment_method"],
        paymentCode: json["payment_code"],
        shippingDistrictId: json["shipping_district_id"],
        shippingCityId: json["shipping_city_id"],
        shippingZone: json["shipping_zone"],
        shippingZoneId: json["shipping_zone_id"],
        shippingCountry: json["shipping_country"],
        shippingCountryId: json["shipping_country_id"],
        shippingAddressFormat: json["shipping_address_format"],
        shippingCustomField:
            List<dynamic>.from(json["shipping_custom_field"].map((x) => x)),
        shippingMethod: json["shipping_method"],
        shippingCode: json["shipping_code"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        vouchers: List<dynamic>.from(json["vouchers"].map((x) => x)),
        comment: json["comment"],
        total: json["total"],
        affiliateId: json["affiliate_id"],
        commission: json["commission"],
        marketingId: json["marketing_id"],
        tracking: json["tracking"],
        languageId: json["language_id"],
        currencyId: json["currency_id"],
        currencyCode: json["currency_code"],
        currencyValue: json["currency_value"],
        ip: json["ip"],
        forwardedIp: json["forwarded_ip"],
        userAgent: json["user_agent"],
        acceptLanguage: json["accept_language"],
        orderId: json["order_id"],
        payment: json["payment"],
      );

  Map<String, dynamic> toJson() => {
        "totals": List<dynamic>.from(totals.map((x) => x.toJson())),
        "invoice_prefix": invoicePrefix,
        "store_id": storeId,
        "store_name": storeName,
        "store_url": storeUrl,
        "customer_id": customerId,
        "customer_group_id": customerGroupId,
        "telephone": telephone,
        "custom_field": customField,
        "payment_district_id": paymentDistrictId,
        "payment_city_id": paymentCityId,
        "payment_zone": paymentZone,
        "payment_zone_id": paymentZoneId,
        "payment_country": paymentCountry,
        "payment_country_id": paymentCountryId,
        "payment_address_format": paymentAddressFormat,
        "payment_custom_field": paymentCustomField,
        "payment_method": paymentMethod,
        "payment_code": paymentCode,
        "shipping_district_id": shippingDistrictId,
        "shipping_city_id": shippingCityId,
        "shipping_zone": shippingZone,
        "shipping_zone_id": shippingZoneId,
        "shipping_country": shippingCountry,
        "shipping_country_id": shippingCountryId,
        "shipping_address_format": shippingAddressFormat,
        "shipping_custom_field":
            List<dynamic>.from(shippingCustomField.map((x) => x)),
        "shipping_method": shippingMethod,
        "shipping_code": shippingCode,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "vouchers": List<dynamic>.from(vouchers.map((x) => x)),
        "comment": comment,
        "total": total,
        "affiliate_id": affiliateId,
        "commission": commission,
        "marketing_id": marketingId,
        "tracking": tracking,
        "language_id": languageId,
        "currency_id": currencyId,
        "currency_code": currencyCode,
        "currency_value": currencyValue,
        "ip": ip,
        "forwarded_ip": forwardedIp,
        "user_agent": userAgent,
        "accept_language": acceptLanguage,
        "order_id": orderId,
        "payment": payment,
      };
}

class Product {
  Product({
    this.key,
    this.productId,
    this.name,
    this.model,
    this.option,
    this.recurring,
    this.image,
    this.quantity,
    this.subtract,
    this.price,
    this.total,
    this.href,
  });

  String key;
  String productId;
  String name;
  String model;
  List<Option> option;
  String recurring;
  String image;
  String quantity;
  String subtract;
  String price;
  String total;
  String href;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        key: json["key"],
        productId: json["product_id"],
        name: json["name"],
        model: json["model"],
        option:
            List<Option>.from(json["option"].map((x) => Option.fromJson(x))),
        recurring: json["recurring"],
        image: json["image"],
        quantity: json["quantity"],
        subtract: json["subtract"],
        price: json["price"],
        total: json["total"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "product_id": productId,
        "name": name,
        "model": model,
        "option": List<dynamic>.from(option.map((x) => x.toJson())),
        "recurring": recurring,
        "image": image,
        "quantity": quantity,
        "subtract": subtract,
        "price": price,
        "total": total,
        "href": href,
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

class Total {
  Total({
    this.title,
    this.text,
  });

  String title;
  String text;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        title: json["title"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
      };
}
