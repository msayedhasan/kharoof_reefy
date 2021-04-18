import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'dart:math' as math;

class CompanyRequests extends StatelessWidget {
  const CompanyRequests({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f8ff),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: true,
          isHome: false,
          categoryName: 'طلبات الشركة',
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: deviceWidth,
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                  // controller: ,
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
                  // controller: ,
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
                  // controller: ,
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
                  // controller: ,
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
                  // controller: ,
                  minLines: 3,
                  maxLines: 5,
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
                  onTap: () {},
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
