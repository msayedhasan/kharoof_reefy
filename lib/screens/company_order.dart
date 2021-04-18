import 'package:flutter/material.dart';
import 'package:kharoof_reefy/Utils/color.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'dart:math' as math;

class CompanyOrder extends StatefulWidget {
  CompanyOrder({Key key}) : super(key: key);

  @override
  _CompanyOrderState createState() => _CompanyOrderState();
}

class _CompanyOrderState extends State<CompanyOrder> {
  String c_name, c_phone, c_address, c_email, c_content;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _displaySnackBar(BuildContext context, String txt) {
      final snackBar = SnackBar(content: Text(txt));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    _sendInquiry() async {
      bool rs = await OpenCartApiService().sendCompanyOrder({
        "company_name": c_name,
        "phone_number": c_phone,
        "address": c_address,
        "email": c_email,
        "content": c_content
      });
      if (rs) {
        _displaySnackBar(context, "Order palaced ");
      } else {
        _displaySnackBar(context, "Check your order information");
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: background_color,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: true,
          categoryName: "طلبات الشركة",
          isHome: false,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: deviceWidth,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffe5a65f),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/trophy.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  onChanged: (value) {
                    c_name = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    fillColor: Colors.white,
                    hintText: "اسم الشركة",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    c_phone = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    fillColor: Colors.white,
                    hintText: "رقم الجوال",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    c_address = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    fillColor: Colors.white,
                    hintText: "عنوان الطلب",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    c_email = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    fillColor: Colors.white,
                    hintText: "البريد الالكتروني",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    c_content = value;
                  },
                  minLines: 4,
                  maxLines: 8,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    fillColor: Colors.white,
                    hintText: "مواصفات الطلب",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _sendInquiry,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffe5a65f),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ارسال الطلب',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Icon(
                              Icons.arrow_back,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
