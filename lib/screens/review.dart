import 'package:flutter/material.dart';
import 'package:kharoof_reefy/Utils/color.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'dart:math' as math;

class SendReview extends StatefulWidget {
  SendReview({Key key}) : super(key: key);

  @override
  _SendReviewState createState() => _SendReviewState();
}

class _SendReviewState extends State<SendReview> {
  String c_order_id, c_content;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _displaySnackBar(BuildContext context, String txt) {
      final snackBar = SnackBar(content: Text(txt));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    _sendReview() async {
      bool rs = await OpenCartApiService().sendReview({
        "order_id": c_order_id,
        "content": c_content,
      });
      if (rs) {
        _displaySnackBar(context, " thank you for your time  ");
      } else {
        _displaySnackBar(context, "Check your reiview information");
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: background_color,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: true,
          categoryName: "تقييم التطبيق",
          isHome: false,
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
                  onChanged: (value) {
                    c_order_id = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    fillColor: Colors.white,
                    hintText: 'Your Order id',
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
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    fillColor: Colors.white,
                    hintText: "محتوي التقييم",
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
                  onTap: _sendReview,
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
                            'ارسال التقييم',
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
