import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kharoof_reefy/models/entites/account.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';
import 'package:kharoof_reefy/utils/color.dart';
import 'package:kharoof_reefy/utils/my_padding.dart';
import 'package:kharoof_reefy/utils/size_config.dart';
import 'package:kharoof_reefy/utils/text_style.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/my_points/Points_earned_shape.dart';
import 'package:kharoof_reefy/widgets/my_points/card_point_shape.dart';

class MyPoints extends StatefulWidget {
  @override
  _MyPointsState createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {
  Account account;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAccount();
    });
  }

  _getAccount() async {
    var rs = await OpenCartApiService().getAccount();
    if (rs != null) {
      setState(() {
        account = rs;
      });
    } else {
      print("account null");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (account == null) {
      return Scaffold(
        backgroundColor: background_color,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            hasBack: true,
            categoryName: "نقاطى ",
            isHome: false,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: background_color,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: true,
          categoryName: "نقاطى ",
          isHome: false,
        ),
      ),
      body: Padding(
        padding: PADDING_symmetric(verticalFactor: 2, horizontalFactor: 2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CardPointShape(
                point: account.rewardTotal ?? "0.0",
              ),
              SizedBox(height: 5),
              account.rewards != null && account.rewards.length > 0
                  ? Padding(
                      padding: PADDING_symmetric(
                          verticalFactor: 1, horizontalFactor: 4),
                      child: Text(
                        "احداث",
                        style: TX_STYLE_black_14Point5,
                      ),
                    )
                  : Container(),
              SizedBox(height: 5),
              account.rewards != null && account.rewards.length > 0
                  ? PointsEarnedShape(
                      rewards: account.rewards ?? [],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
