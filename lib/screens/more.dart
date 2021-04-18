import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';
import 'package:kharoof_reefy/models/entites/account.dart';
import 'package:kharoof_reefy/screens/about_app.dart';
import 'package:kharoof_reefy/screens/bank_accounts.dart';
import 'package:kharoof_reefy/screens/company_requests.dart';
import 'package:kharoof_reefy/screens/company_order.dart';
import 'package:kharoof_reefy/screens/login.dart';
import 'package:kharoof_reefy/screens/my_points.dart';
import 'package:kharoof_reefy/services/auth_service.dart';
import 'package:kharoof_reefy/screens/review.dart';
import 'package:kharoof_reefy/utils/color.dart';
import 'package:kharoof_reefy/utils/my_padding.dart';
import 'package:kharoof_reefy/utils/size_config.dart';
import 'package:kharoof_reefy/utils/text_style.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/my_points/image_container.dart';

import 'dart:math' as math; // import this

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  void initState() {
    super.initState();
    _isAuthentificated();
  }

  bool _isLoading = false;
  Account account;

  bool isAuthtificated = false;

  _isAuthentificated() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    var rs = await AuthService.instance.checkAuth();
    var parsedAccount = await OpenCartApiService().getAccount();
    if (parsedAccount != null) {
      setState(() {
        account = parsedAccount;
      });
    } else {
      print("account null");
    }
    if (mounted) {
      setState(() {
        isAuthtificated = rs;
        _isLoading = false;
      });
    }
  }

  _logout() async {
    try {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      final res = await AuthService.instance.logout();
      print(res);
      if (!res) {
        if (mounted) {
          setState(() {
            isAuthtificated = false;
            _isLoading = false;
          });
        }
      }
      if (mounted) {
        setState(() {
          isAuthtificated = false;
          _isLoading = false;
        });
      }
    } catch (err) {
      print(err);
    }
  }

  _login() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        elevation: 6.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Column(children: <Widget>[
          Image(
//                  color: Theme.of(context).accentColor,
            height: 70.0,
            width: 90.0,
            image: AssetImage("assets/images/main_logo.png"),
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          Text(
            "الرجاء تسجيل الدخول برقم هاتفك",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          )
        ]),
        actions: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: FlatButton(
                child: Text(
                  " تسجيل الدخول",
                  style: TextStyle(
                    color: Color(0xffe5a65f),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Login()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  cardProfile() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
      padding: PADDING_symmetric(verticalFactor: 1, horizontalFactor: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ImageContainer(
            path: 'assets/images/trophy.png',
            width: SizeConfig.screenWidth * 0.2,
            height: SizeConfig.screenHeight * 0.1,
          ),
          SizedBox(
            width: SizeConfig.blockSizeVertical * 2,
          ),

          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  account != null
                      ? Text(
                          // account.toString(),
                          account.telephone,
                          style: TX_STYLE_black_14Point5,
                        )
                      : Container(),
                  Text("مرحبا بك فى تطبيق الخروف الريفى"),
                ],
              ),
            ),
          ),

          // Text("ssssssss"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: background_color,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: false,
          isHome: false,
          categoryName: "المزيد",
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(index: 3),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              cardProfile(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyPoints();
                  }));
                },
                child: card_shape('assets/images/trophy.png', "نقاطى"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CompanyOrder();
                  }));
                },
                child: card_shape('assets/images/trophy.png', "طلبات الشركة"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AboutApp();
                  }));
                },
                child: card_shape('assets/images/trophy.png', "عن التطبيق"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BankAccounts();
                  }));
                },
                child:
                    card_shape('assets/images/trophy.png', "حساباتنا البنكية"),
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return CompanyOrder();
              //     }));
              //   },
              //   child: card_shape('assets/images/trophy.png', "company order"),
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SendReview();
                  }));
                },
                child: card_shape('assets/images/trophy.png', "تقييم التطبيق"),
              ),
              SizedBox(height: 10),
              _isLoading
                  ? Center(
                      child: SpinKitCircle(
                        color: Color(0xffb09577),
                        size: 30.0,
                      ),
                    )
                  : isAuthtificated
                      ? GestureDetector(
                          onTap: _logout,
                          child: Text(
                            "تسجيل الخروج",
                            style: TX_STYLE_black_14Point5.copyWith(color: red),
                          ),
                        )
                      : GestureDetector(
                          onTap: _login,
                          child: Text(
                            "تسجيل الدخول",
                            style: TX_STYLE_black_14Point5.copyWith(color: red),
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }

  card_shape(path, title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
      padding: PADDING_symmetric(horizontalFactor: 2, verticalFactor: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageContainer(
                path: path,
                width: SizeConfig.screenWidth * 0.1,
                height: SizeConfig.blockSizeVertical * 5.5,
                scale: 1.5,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 3,
              ),
              Text(
                title,
                style: TX_STYLE_black_14.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Icon(
              Icons.arrow_back_ios,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
