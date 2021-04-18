import 'package:flutter/material.dart';
import 'package:kharoof_reefy/utils/color.dart';
import 'package:kharoof_reefy/utils/my_padding.dart';
import 'package:kharoof_reefy/utils/text_style.dart';

class BankAccountShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PADDING_symmetric(verticalFactor: 1),
      padding: PADDING_symmetric(horizontalFactor: 3, verticalFactor: 1),
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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "البنك الأهلي",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'مؤسسة خالد محمود محمد ظهار للمواشي',
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'رقم الحساب: ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      '16900000100809',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الأيبان: ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      'SA9010000016900000100809',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
