import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/font_styles.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/utils/color.dart';
import 'package:kharoof_reefy/utils/size_config.dart';
class OrderDetailsShape extends StatelessWidget {
  String imageURL;
  String productName;
  String productPrice;
  OrderDetailsShape(this.imageURL,this.productName,this.productPrice);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white),
      height: 118,
      child: Stack(
        children: [
          Positioned(
            top:6,
            right:6,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xfff5f5f4)),
              height: 106,
              width: 106,
            ),
          ),
          Positioned(
            top:10,
            right:5,
            child: Image.asset('${imageURL}',width: SizeConfig.screenWidth * 0.23,),
          ),
          Positioned(
              top:10,
              right:120,
              child: Text('${productName}',style: productMainTitle, )),
          Positioned(
              top:45,
              right:130,
              child: Image.asset('assets/images/product_des_icon.png',width: 22,)),
          Positioned(
              top:45,
              right:150,
              child: Row(
                children: [
                  Text('ريال سعودى',style: productPriceSAR),
                  Text(' $productPrice',style: productPriceStyle,),

                ],
              )),

          Positioned(
              top:25,
              right:220,
              child: Container(
                width: SizeConfig.screenWidth * 0.25,
                height: SizeConfig.screenHeight * 0.05,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(25),

                  ),
                  border: Border.all(
                    color: Color(0xffe5a65f),
                  ),

                ),
                child: Center(child: Text('تفاصيل',style: TextStyle(fontSize: 14,color: Color(0xffe5a65f)),)),
              )
          ),
        ],
      ),

    );
  }
}
