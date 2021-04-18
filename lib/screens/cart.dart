import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/models/entites/cart.dart';
import 'package:kharoof_reefy/models/product.dart';
import 'package:kharoof_reefy/screens/check_out.dart';
import 'package:kharoof_reefy/screens/login.dart';
import 'package:kharoof_reefy/services/auth_service.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';
import 'package:kharoof_reefy/utils/size_config.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_bottom_bar.dart';
import 'package:kharoof_reefy/widgets/cart/cart_list.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Cart item;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var isDeletedItem;

  String coupons;

  TextEditingController couponsInput = TextEditingController();
  TextEditingController rewardInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isAuthentificated();
      _getCart();
    });
  }

  bool isAuthtificated = null;

  _isAuthentificated() async {
    var rs = await AuthService.instance.checkAuth();
    if (mounted) {
      setState(() {
        isAuthtificated = rs;
      });
    }
  }

  _displaySnackBar(BuildContext context, String txt) {
    final snackBar = SnackBar(content: Text(txt));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _getCart() async {
    var rs = await OpenCartApiService().getCart();
    if (rs != null) {
      if (mounted) {
        setState(() {
          item = rs;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _body();
  }

  _body() {
    if (isAuthtificated == false) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("الرجاء تسجيل الدخول برقم هاتفك"),
            ),
            MaterialButton(
              child: Text(" تسجيل الدخول"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Login()));
              },
            )
          ],
        ),
      );
    }
    if (item == null) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              hasBack: false,
              isHome: false,
              categoryName: 'السلة',
            )),
        // bottomNavigationBar: CustomBottomBar(
        //   index: 2,
        // ),
        body: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (item.products.isEmpty) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            hasBack: false,
            isHome: false,
            categoryName: 'السلة',
          ),
        ),
        // bottomNavigationBar: CustomBottomBar(
        //   index: 2,
        // ),
        body: Align(
          alignment: Alignment.center,
          child: Text("سلة فارغة"),
        ),
      );
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: false,
          isHome: false,
          categoryName: 'السلة',
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(index: 2),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            // height: deviceHeight * 0.4,
            child: CartList(
              allProducts: item.products,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          width: deviceWidth * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey[200],
                offset: new Offset(0.0, 0.0),
                blurRadius: 2.0,
                spreadRadius: 1.0,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: rewardInput,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        fillColor: Colors.white,
                        hintText: "ادخل  المكافآت  ",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey[300],
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () async {
                      if (rewardInput.text != null) {
                        var rs = await OpenCartApiService()
                            .rewardPoint(rewardInput.text);
                        if (rs) {
                          _getCart();
                          _displaySnackBar(context, "تم  ");
                        } else {
                          _displaySnackBar(
                              context, " تحذير: لايوجد لديك  نقاط");
                        }
                      } else {
                        _displaySnackBar(context, "  ");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: deviceWidth * 0.20,
                        height: deviceWidth * 0.08,
                        decoration: BoxDecoration(
                          color: Color(0xffe5a65f),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'تطبيق',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: couponsInput,
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          fillColor: Colors.white,
                          hintText: "ادخل رقم الكوبون",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () async {
                        if (couponsInput.text != null) {
                          var rs =
                              await OpenCartApiService().applyCoupon(coupons);
                          if (rs) {
                            _getCart();
                            _displaySnackBar(context, "تم تفعيل الكوبون");
                          } else {
                            _displaySnackBar(context,
                                " تحذير: رمز القسيمة خاطيء, أو انتهى أو تم استخدام الحد الأقصى للقسيمة!");
                          }
                        } else {
                          _displaySnackBar(context, "يرجى إدخال رمز القسيمة  ");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: deviceWidth * 0.20,
                          height: deviceWidth * 0.08,
                          decoration: BoxDecoration(
                            color: Color(0xffe5a65f),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'تطبيق',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: item.totals.map((e) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          e.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: 16,
                          ),
                        ),
                        Text(
                          e.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Container(
                width: deviceWidth * 1,
                height: 2,
                color: Colors.grey.withOpacity(0.2),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CheckOut();
                  }));
                },
                child: Container(
                  width: deviceWidth * 0.7,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xffe5a65f),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'متابعة',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
