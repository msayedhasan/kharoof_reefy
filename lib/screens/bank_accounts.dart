import 'package:flutter/material.dart';
import 'package:kharoof_reefy/utils/color.dart';
import 'package:kharoof_reefy/utils/my_padding.dart';
import 'package:kharoof_reefy/utils/size_config.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/bank_account_shape.dart';

class BankAccounts extends StatelessWidget {
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
          categoryName: "الحسابات البنكية",
        ),
      ),
      body: Padding(
        padding: PADDING_symmetric(verticalFactor: 1, horizontalFactor: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BankAccountShape(),
          ],
        ),
      ),
    );
  }
}
