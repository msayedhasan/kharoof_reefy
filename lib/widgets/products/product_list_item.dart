import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/font_styles.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/models/productModel.dart';
import 'package:kharoof_reefy/screens/product_details.dart';

class ProductListItem extends StatelessWidget {
  final String imageURL;
  final String productName;
  final String productPrice;
  final ProductModel currentProduct;

  ProductListItem(
      {@required this.currentProduct,
      this.imageURL,
      this.productName,
      this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(21, 20, 21, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductDetails(
              currentProduct: currentProduct,
            );
          }));
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
            ),
            height: 118,
            child: Row(
              children: [
                Container(
                  height: 106,
                  width: 106,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xfff5f5f4),
                    image: DecorationImage(
                      image: NetworkImage(imageURL),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '$productName',
                            style: productMainTitle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/product_des_icon.png',
                                width: 22,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'سعر يبدأ من $productPrice',
                                style: productPriceStyle,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: deviceWidth * 0.5,
                          height: deviceHeight * 0.04,
                          decoration: BoxDecoration(
                            color: Color(0xffe5a65f),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Center(
                            child: Text(
                              'اطلب الان',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
