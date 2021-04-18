import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/font_styles.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/screens/cart.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';

class CartListItem extends StatelessWidget {
  String imageURL;
  String productName;
  String productPrice;
  String productQuantity;
  String productKey;

  CartListItem({
    this.productKey,
    this.imageURL,
    this.productName,
    this.productPrice,
    this.productQuantity,
  });

  double _pricePrice(String price) {
    var _price = price.split(" ")[0];
    if (_price.contains(",")) {
      return double.parse(_price.replaceAll(",", "").trim());
    } else {
      return double.parse(_price..trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey[200],
                offset: new Offset(0.0, 0.0),
                blurRadius: 1.0,
                spreadRadius: 0.5,
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[200],
                      offset: new Offset(0.0, 0.0),
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                    )
                  ],
                ),
                child: Image.network(
                  '$imageURL',
                  width: deviceWidth * 0.23,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '$productName',
                              style: productMainTitle,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'الكمية: ',
                                style: productPriceStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                productQuantity ?? '',
                                style: TextStyle(
                                  color: Color(0xffe5a65f),
                                  fontSize: 14,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              children: [
                                Container(
                                  child: Image.asset(
                                    'assets/images/product_des_icon.png',
                                    width: 15,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  (_pricePrice(
                                              '${productPrice.contains('ر.س') ? productPrice.split('ر.س')[0] : productPrice}') *
                                          int.parse(productQuantity))
                                      .toStringAsFixed(0),
                                  overflow: TextOverflow.ellipsis,
                                  style: productPriceStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' ريال سعودى ',
                                  overflow: TextOverflow.ellipsis,
                                  style: productPriceStyle,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (context) => new AlertDialog(
                                  content: Text('أنت متأكد من حذف هذا المنتج'),
                                  actions: <Widget>[
                                    new TextButton(
                                      onPressed: () async {
                                        await OpenCartApiService()
                                            .removeFromCart(productKey);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => CartPage()));
                                      },
                                      child: new Text(
                                        'نعم',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    new TextButton(
                                      onPressed: () async {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      child: new Text(
                                        'لا',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                'assets/images/delete_icon.png',
                                width: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Icon(
              //   Icons.delete,
              //   color: Colors.grey,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
