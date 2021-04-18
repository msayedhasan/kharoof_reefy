import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/utils/color.dart';
import 'package:kharoof_reefy/utils/my_padding.dart';
import 'package:kharoof_reefy/utils/size_config.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: background_color,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: true,
          isHome: false,
          categoryName: "عن التطبيق",
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(index:0),
      body: Container(
        width: deviceWidth,
        padding: PADDING_symmetric(verticalFactor: 5, horizontalFactor: 2),
        margin: PADDING_symmetric(verticalFactor: 2, horizontalFactor: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey[200],
              offset: new Offset(0.0, 0.0),
              blurRadius: 1.0,
              spreadRadius: 0.5,
            )
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/main_logo.png',
                  width: SizeConfig.screenWidth / 3,
                  height: SizeConfig.screenWidth / 4,
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/header_logo.png',
                  width: SizeConfig.screenWidth / 2,
                  height: SizeConfig.screenWidth / 4.5,
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: deviceWidth,
                  child: Text(
                    "الخروف الريفي",
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      height: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: deviceWidth,
                  child: Text(
                    "متخصصون في ( انتاج / وتربية ) الخرفان الحرية لتصل منازلكم مذبوحة ومقطعه ومغلفة باحترافية في عرباتنا المبردة",
                    overflow: TextOverflow.clip,
                    style: TextStyle(height: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
