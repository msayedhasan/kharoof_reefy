import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/font_styles.dart';
import 'package:kharoof_reefy/utils/color.dart';
import 'package:kharoof_reefy/utils/my_padding.dart';
import 'package:kharoof_reefy/utils/size_config.dart';
import 'package:kharoof_reefy/utils/text_style.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/order_details_shape.dart';
import 'package:kharoof_reefy/widgets/products/product_list_item.dart';
class OrderDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: background_color,
    appBar: PreferredSize(
    preferredSize: Size.fromHeight(70),
    child: CustomAppBar(hasBack: true,isHome: false,categoryName: "طلب 92345",)),

    body: Padding(
    padding: const EdgeInsets.fromLTRB(21,20,21,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
         Container(

             child: OrderDetailsShape("assets/images/hary_icon.png", "تيس بلدى","100",)),
             text_shape("معلومات الطلب"),

             container_shape('رقم الطلب','رقم232'),
             container_shape('رقم الطلب','رقم232'),
             container_shape('رقم الطلب','رقم232'),
             container_shape('رقم الطلب','رقم232'),

             text_shape("معلومات التوصيل"),
          container_shape('رقم الطلب','رقم232'),
          container_shape('رقم الطلب','رقم232'),





        ],
      ),
    )
    );
  }

  container_shape(txt1,txt2){
    return Padding(
      padding: PADDING_symmetric(verticalFactor: 1),
      child: Container(
        height: SizeConfig.screenHeight * 0.07,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(25),

          ),


        ),
        child: Padding(
          padding: PADDING_symmetric(horizontalFactor: 4),
          child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

               Text(txt2,style: TextStyle(fontSize: 14,color: black),),
              Text(txt1,style: TextStyle(fontSize: 14,color: gray),),
            ],
          ),
        ),
      ),
    );

  }
  text_shape(String title){
    return    Padding(
      padding: PADDING_symmetric(verticalFactor: 1,horizontalFactor: 6),
      child:   Text(title,style: TX_STYLE_black_14Point5,),
    );
  }
}
