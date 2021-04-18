import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/screens/cart.dart';
import 'package:kharoof_reefy/screens/main_navigation.dart';

class AddedToBasket extends StatefulWidget {
  @override
  _AddedToBasketState createState() => _AddedToBasketState();
}

class _AddedToBasketState extends State<AddedToBasket> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        elevation: 20,
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffe5a65f),
                ),
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'تم الإضافة الى السلة',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'هل ترغب فى مواصلة التسوق او فتح السلة؟',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return MainNavigation(
                              routeIndex: 2,
                            );
                          },
                        ),
                        (Route<dynamic> route) => false,
                      );

                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return CartPage();
                      // }));
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xffe5a65f)),
                    ),
                    child: Text(
                      'عرض السلة',
                      style: TextStyle(color: Color(0xffe5a65f), fontSize: 14),
                    ),
                  ),
                  SizedBox(width: 5),
                  RaisedButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      Navigator.popUntil(
                        context,
                        (Route<dynamic> route) => route.isFirst,
                      );
                    },
                    color: Color(0xffe5a65f),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xffe5a65f)),
                    ),
                    child: Text(
                      'مواصلة التسوق',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
