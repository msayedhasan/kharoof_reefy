import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:kharoof_reefy/collection/categories.dart';
import 'package:kharoof_reefy/consts/api_consts.dart';
import 'package:kharoof_reefy/models/category_model.dart';

class ApiServices {
  Future getCategories() async {
    Client client = Client();
    try {
      await client.get('${apiURL}feed/rest_api/categories&level=2', headers: {
        '$tokenKey': '$tokenValue',
        '$sessionKey': '$sessionValue'
      }).then((response) async {
        print('res');
        Map<String, dynamic> responseData = await jsonDecode(response.body);
        for (var item in responseData['data']) {
          // print(item);
          // int countProductsNumber = 0;
          // countProductsNumber =
          //     await countProducts(item['category_id'].toString());
          // for (var subItem in item['categories']) {
          //   countProductsNumber +=
          //       await countProducts(subItem['category_id'].toString());
          // }
          CategoryModel instance = CategoryModel(
            name: item['name'],
            id: item['category_id'].toString(),
            image: item['image'],
            price: item['price'],
            // countProducts: countProductsNumber.toString(),
            countProducts: item['product_count'].toString(),
            hasSubCategory: (item['categories'] as List).length == 0,
          );
          allCategories.add(instance);
          for (var subItem in item['categories']) {
            // int countProductsNumberForSub = 0;
            // countProductsNumberForSub =
            //     await countProducts(subItem['category_id'].toString());
            // for (var subSubItem in subItem['categories']) {
            //   countProductsNumber +=
            //       await countProducts(subSubItem['category_id'].toString());
            // }
            CategoryModel subInstance = CategoryModel(
              name: subItem['name'],
              id: subItem['category_id'].toString(),
              image: subItem['image'],
              price: subItem['price'],
              parentID: subItem['parent_id'].toString(),
              // countProducts: countProductsNumberForSub.toString(),
              countProducts: subItem['product_count'].toString(),
              hasSubCategory: (subItem['categories'] as List).isNotEmpty,
            );
            subCategories.add(subInstance);
          }
        }
      });
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  Future<int> countProducts(String categoryID) async {
    Client client = Client();
    try {
      return await client.get(
          '${apiURL}feed/rest_api/products&category=$categoryID',
          headers: {
            tokenKey: tokenValue,
            sessionKey: sessionValue
          }).then((response) async {
        final parsed =
            json.decode(response.body)['data'].cast<Map<String, dynamic>>();
        List<dynamic> products = parsed.map<dynamic>((item) => item).toList();
        return products.length;
      });
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return 0;
  }

  Future getProducts(String categoryID) async {
    Client client = Client();
    try {
      return await client.get(
          '${apiURL}feed/rest_api/products&category=$categoryID',
          headers: {
            tokenKey: tokenValue,
            sessionKey: sessionValue
          }).then((response) async {
        Map<String, dynamic> responseData = await jsonDecode(response.body);
        return responseData['data'];
      });
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }
}
