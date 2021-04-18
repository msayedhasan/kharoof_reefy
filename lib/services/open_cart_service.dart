import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kharoof_reefy/Utils/http_util.dart';
import 'package:kharoof_reefy/config.dart';
import 'package:kharoof_reefy/models/entites/account.dart';
import 'package:kharoof_reefy/models/entites/address.dart';
import 'package:kharoof_reefy/models/entites/banner.dart';
import 'package:kharoof_reefy/models/entites/cart.dart';
import 'package:kharoof_reefy/models/entites/category.dart';
import 'package:kharoof_reefy/models/entites/city.dart';
import 'package:kharoof_reefy/models/entites/district.dart';
import 'package:kharoof_reefy/models/entites/order.dart';
import 'package:kharoof_reefy/models/entites/order_confirmation_data.dart';
import 'package:kharoof_reefy/models/entites/order_detail.dart';
import 'package:kharoof_reefy/models/entites/product_detail.dart';
import 'package:kharoof_reefy/models/entites/shipping_payment_method.dart';
import 'package:kharoof_reefy/models/entites/user.dart';
import 'package:kharoof_reefy/models/entites/zone.dart';

abstract class BaseService {
  Future<List<BannerModel>> getBanners();
  Future<List<ProductDetail>> getProducts();
  Future<ProductDetail> getProductById(int id);
  Future<List<Address>> getAddresses();
}

class OpenCartApiService extends BaseService {
  //  Future<List<Category>> getCateg

  Future<List<BannerModel>> getBanners() async {
    var endpoint = "feed/rest_api/banners&key=slider";
    var url = Config.API + endpoint;
    debugPrint("call get banner $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      return parsed
          .map<BannerModel>((item) => BannerModel.fromJson(item))
          .toList();
    } else {
      print(response.body);
    }
  }

  @override
  Future<ProductDetail> getProductById(int id) async {
    var endpoint = "feed/rest_api/products&id=$id";
    var url = Config.API + endpoint;
    debugPrint("call product detail : $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      return ProductDetail.fromJson(json.decode(response.body)['data']);
    } else {
      print(response.body);
    }
  }

  Future<List<ProductDetail>> getProducts() async {
    var endpoint = "feed/rest_api/products";
    var url = Config.API + endpoint;
    debugPrint("call products $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();

      var products = parsed
          .map<ProductDetail>((item) => ProductDetail.fromJson(item))
          .toList();

      return products;
    } else {
      print(response.body);
    }
  }

  Future<Map<String, List<MyOrder>>> getOrders() async {
    var endpoint = "rest/order/orders";
    var url = Config.API + endpoint;
    debugPrint("call getOrders $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      var orders = Map<String, List<MyOrder>>();
      (json.decode(response.body)['data'] as Map<String, dynamic>)
          .forEach((key, value) {
        List<MyOrder> items =
            (value as List).map((e) => MyOrder.fromJson(e)).toList();

        orders[key] = items;
      });

      return orders;
    } else {
      print(response.body);
    }
  }

  @override
  Future<OrderDetail> getOrderDetail(String id) async {
    var endpoint = "rest/order/orders&id=$id";
    var url = Config.API + endpoint;
    debugPrint("call order detail : $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      return OrderDetail.fromJson(json.decode(response.body)['data']);
    } else {
      print(response.body);
    }
  }

  Future<String> producLivePrice(
      String _productID, int quantity, _options) async {
    var endpoint =
        "feed/rest_api/price&product_id=$_productID&quantity=$quantity";
    var url = Config.API + endpoint;
    debugPrint("call live price $url");
    var headers = await HttpUtils.headers();
    var _opts = Map();
    _opts["option"] = _options;

    var response = await post(url, headers: headers, body: json.encode(_opts));
    if (response.statusCode == 200) {
      return json.decode(response.body)["data"]["price"];
    } else {
      print(response.body);
    }
  }

  Future<bool> sendCompanyOrder(dynamic order) async {
    var endpoint = "rest/utility/companyOrder";
    var url = Config.API + endpoint;
    debugPrint("send order company $url");
    var headers = await HttpUtils.headers();

    var response = await post(url, headers: headers, body: json.encode(order));
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  Future<bool> sendReview(dynamic review) async {
    var endpoint = "rest/utility/review";
    var url = Config.API + endpoint;
    debugPrint("send review  $url");
    var headers = await HttpUtils.headers();

    var response = await post(url, headers: headers, body: json.encode(review));
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  @override
  Future<List<Address>> getAddresses() async {
    var endpoint = "rest/account/address";
    var url = Config.API + endpoint;
    debugPrint("call get address $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      try {
        final parsed = json
            .decode(response.body)['data']['addresses']
            .cast<Map<String, dynamic>>();

        return parsed.map<Address>((item) => Address.fromJson(item)).toList();
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<PaymentMethod>> getPaymentMethods() async {
    var endpoint = "rest/utility/address";
    var url = Config.API + endpoint;
    debugPrint("call PaymentMethod by defalut address $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      try {
        final parsed = json
            .decode(response.body)['data']['payment']
            .cast<Map<String, dynamic>>();

        return parsed
            .map<PaymentMethod>((item) => PaymentMethod.fromJson(item))
            .toList();
      } catch (e) {
        print(e);
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<Address> getAddressByID(id) async {
    var endpoint = "rest/account/address&id=$id";
    var url = Config.API + endpoint;
    debugPrint("call get address $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      return Address.fromJson(json.decode(response.body)['data']);
    } else {
      print("error");
    }
  }

  @override
  Future<User> getUserAccount() async {
    var endpoint = "rest/account/account";
    var url = Config.API + endpoint;
    debugPrint("call get account $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      var user = User.fromJson(json.decode(response.body)['data']);
      print(user);
      return user;
    } else {
      print("error");
    }
  }

  Future<Account> getAccount() async {
    var endpoint = "rest/account/account";
    var url = Config.API + endpoint;
    debugPrint("call get account $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      var user = Account.fromJson(json.decode(response.body)['data']);
      print(user);
      return user;
    } else {
      print("error");
    }
  }

  @override
  Future<ShippingAndPaymentMethed> getShippingAndPaymentMethod() async {
    var endpoint = "rest/utility/shippingPaymentMethods";
    var url = Config.API + endpoint;
    debugPrint("call get SippingAndPaymentMethed $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      return ShippingAndPaymentMethed.fromJson(
          json.decode(response.body)['data']);
    } else {
      print(response.body);
    }
  }

  // @override
  // Future<dynamic> setPaymentMethod(_code) async {
  //   var endpoint = "rest/payment_method/payments";
  //   var url = Config.API + endpoint;
  //   var body = {"payment_method": _code, "agree": "1", "comment": "string"};
  //   var headers = await HttpUtils.headers();
  //   var response = await post(url, headers: headers, body: json.encode(body));
  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     print("error");
  //   }
  // }

  // @override
  // Future<dynamic> setShippingMethod(_code) async {
  //   var endpoint = "rest/shipping_method/shippingmethods";
  //   var url = Config.API + endpoint;
  //   var _body = {"shipping_method": "flat.flat", "comment": "string"};
  //   var headers = await HttpUtils.headers();
  //   var response = await post(url, headers: headers, body: json.encode(_body));
  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     print(json.decode(response.body));
  //   }
  // }

  Future createAddress(Address address) async {
    // var endpoint = "rest/account/address";
    var endpoint = "rest/utility/address";
    var url = Config.API + endpoint;
    debugPrint("call get address $url");
    print('req.body');
    print(jsonEncode(address));
    var headers = await HttpUtils.headers();
    var response = await post(url, headers: headers, body: jsonEncode(address));
    print('response');
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
      return json.decode(response.body)['data']['address_id'];
    } else {
      return json.decode(response.body);
      return null;
    }
  }

  Future<bool> hasAddresses() async {
    var rs = await getAddresses();
    return rs == null ? false : true;
  }

  Future<bool> updateAddress(Address address) async {
    var endpoint = "rest/account/address&id=${address.addressId}";
    var url = Config.API + endpoint;
    debugPrint("call get address $url");
    var headers = await HttpUtils.headers();
    var response = await put(url, headers: headers, body: jsonEncode(address));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteAddress(String addressID) async {
    var endpoint = "rest/account/address&id=$addressID";
    var url = Config.API + endpoint;
    debugPrint("call get address $url");
    var headers = await HttpUtils.headers();
    var response = await delete(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Zone>> getCountryZone() async {
    var endpoint = "feed/rest_api/country";
    var url = Config.API + endpoint;
    debugPrint("call getCountryZone $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      final parsed = json
          .decode(response.body)['data']['zone']
          .cast<Map<String, dynamic>>();

      return parsed.map<Zone>((item) => Zone.fromJson(item)).toList();
    } else {
      print(response.body);
    }
  }

  Future<List<City>> getZoneCities(String zone_id) async {
    var endpoint = "feed/rest_api/zone&zone_id=$zone_id";
    var url = Config.API + endpoint;
    debugPrint("call getZoneCities $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      print("cities");

      final parsed = json
          .decode(response.body)['data']['cities']
          .cast<Map<String, dynamic>>();

      return parsed.map<City>((item) => City.fromJson(item)).toList();
    } else {
      print(response.body);
    }
  }

  Future<List<District>> getCityDistrict(String city_id) async {
    var endpoint = "feed/rest_api/city&city_id=$city_id";
    var url = Config.API + endpoint;
    debugPrint("call getCityDistrict $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      final parsed = json
          .decode(response.body)['data']['districts']
          .cast<Map<String, dynamic>>();

      return parsed.map<District>((item) => District.fromJson(item)).toList();
    } else {
      print(response.body);
    }
  }

  Future<Cart> getCart() async {
    var endpoint = "rest/cart/cart";
    var url = Config.API + endpoint;
    debugPrint("call getCart : $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      if (json.decode(response.body)['data'] is List) return Cart(products: []);
      return Cart.fromJson(json.decode(response.body)['data']);
    } else {
      print(response.body);
    }
  }

  Future<bool> removeFromCart(String key) async {
    var endpoint = "rest/cart/cart";
    var url = Config.API + endpoint;
    debugPrint("call getCart : $url");

    final request = Request("DELETE", Uri.parse(url));
    var headers = await HttpUtils.headers();
    request.headers.addAll(headers);
    request.body = jsonEncode({"key": key});
    final response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> addItemToCart(item) async {
    var endpoint = "rest/cart/cart";
    var url = Config.API + endpoint;
    debugPrint("call addItemToCart $url");
    var headers = await HttpUtils.headers();
    var _body = jsonEncode(item);
    var response = await post(url, headers: headers, body: _body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return json.decode(response.body)['error'];
    }
  }

  Future<bool> setShippingAddress(addressId) async {
    var endpoint = "rest/utility/address&existing=1";
    var url = Config.API + endpoint;
    debugPrint("call setShippingAddress $url");
    var headers = await HttpUtils.headers();
    var _body = jsonEncode({"address_id": addressId});
    var response = await post(url, headers: headers, body: _body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> updateItemInCart(item) async {
    var endpoint = "rest/cart/cart";
    var url = Config.API + endpoint;
    debugPrint("call addItemToCart $url");
    var headers = await HttpUtils.headers();
    var _body = jsonEncode(item);
    var response = await put(url, headers: headers, body: _body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return json.decode(response.body)['error'];
    }
  }

  Future<bool> applyCoupon(coupon) async {
    var endpoint = "rest/cart/coupon";
    var url = Config.API + endpoint;
    var headers = await HttpUtils.headers();
    var _body = jsonEncode({"coupon": coupon});
    var response = await post(url, headers: headers, body: _body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Future<OrderConfirmationData> orderConfirm(obj) async {
  //   var endpoint = "rest/confirm/confirm";
  //   var url = Config.API + endpoint;
  //   var headers = await HttpUtils.headers();
  //   var _body = jsonEncode({"shipping_method": "flat.flat", "comment": ""});
  //   var response = await post(url, headers: headers, body: _body);
  //   if (response.statusCode == 200) {
  //     return OrderConfirmationData.fromJson(json.decode(response.body)['data']);
  //   } else {
  //     return json.decode(response.body)['error'];
  //   }
  // }

  // Future<String> finishOrder(obj) async {
  //   var endpoint = "rest/confirm/confirm";
  //   var url = Config.API + endpoint;
  //   var headers = await HttpUtils.headers();
  //   var _body = jsonEncode({"shipping_method": "flat.flat", "comment": ""});
  //   var response = await put(url, headers: headers, body: _body);
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body)['data']["order_id"];
  //   } else {
  //     return json.decode(response.body)['error'];
  //   }
  // }

  Future<bool> rewardPoint(points) async {
    var endpoint = "rest/cart/reward";
    var url = Config.API + endpoint;
    debugPrint("call rewardPoint $url");
    var headers = await HttpUtils.headers();

    var response =
        await post(url, headers: headers, body: jsonEncode({"reward": points}));
    print(json.decode(response.body));
    return json.decode(response.body)['success'] == 1;
  }

  //** Start New checkout api */
  //** 1 */
  Future generateCheckoutData() async {
    var endpoint = "rest/utility/generateCheckoutData";
    var url = Config.API + endpoint;
    debugPrint("call generateCheckoutData $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    return json.decode(response.body);
  }

  //** 2 */
  Future setNewAddress(Address address) async {
    var endpoint = "rest/utility/address";
    var url = Config.API + endpoint;
    debugPrint("call get address $url");
    var headers = await HttpUtils.headers();
    var response = await post(url, headers: headers, body: jsonEncode(address));
    return json.decode(response.body);
  }

  //** 3 */
  Future setShippingMethod(_code) async {
    var endpoint = "rest/shipping_method/shippingmethods";
    var url = Config.API + endpoint;
    var _body = {"shipping_method": _code, "comment": ""};
    var headers = await HttpUtils.headers();
    var response = await post(url, headers: headers, body: json.encode(_body));
    return json.decode(response.body);
  }

  //** 4 */
  Future setPaymentMethod(_code) async {
    var endpoint = "rest/payment_method/payments";
    var url = Config.API + endpoint;
    var _body = {"payment_method": _code, "comment": ""};
    var headers = await HttpUtils.headers();
    var response = await post(url, headers: headers, body: json.encode(_body));
    return json.decode(response.body);
  }

  //** 5 */
  Future selectDay(day) async {
    var endpoint = "rest/utility/saveDay";
    var url = Config.API + endpoint;
    var _body = {"day": day};
    var headers = await HttpUtils.headers();
    var response = await post(url, headers: headers, body: json.encode(_body));
    return json.decode(response.body);
  }

  //** 6 */
  Future orderConfirm(shippingMethod) async {
    var endpoint = "rest/confirm/confirm";
    var url = Config.API + endpoint;
    var _body = {"shipping_method": shippingMethod, 'comment': ''};
    var headers = await HttpUtils.headers();
    var response = await post(url, headers: headers, body: json.encode(_body));
    return json.decode(response.body);
  }

  //** 7 */
  Future forPaymentByUsingWebView() async {
    var endpoint = "rest/confirm/confirm&page=pay";
    var url = Config.API + endpoint;
    debugPrint("call forPaymentByUsingWebView $url");
    var headers = await HttpUtils.headers();
    var response = await get(url, headers: headers);
    return json.decode(response.body);
  }

  //** 8 */
  Future finishOrder(shippingMethod) async {
    var endpoint = "rest/confirm/confirm";
    var url = Config.API + endpoint;
    var _body = {"shipping_method": shippingMethod, 'comment': ''};
    var headers = await HttpUtils.headers();
    var response = await put(url, headers: headers, body: json.encode(_body));
    return json.decode(response.body);
  }
  //** End New checkout api */
}
