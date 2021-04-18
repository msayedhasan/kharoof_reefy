import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/models/entites/order.dart';
import 'package:kharoof_reefy/screens/login.dart';
import 'package:kharoof_reefy/services/auth_service.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_bottom_bar.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  Map<String, List<MyOrder>> _orders;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isAuthentificated();
      _getOrders();
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

  _getOrders() async {
    var rs = await OpenCartApiService().getOrders();
    if (rs != null) {
      setState(() {
        _orders = rs;
      });
    } else {
      print("orders null");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isAuthtificated == null) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            hasBack: false,
            isHome: false,
            categoryName: 'طلباتى',
          ),
        ),
        // bottomNavigationBar: CustomBottomBar(index: 1),
        body: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (isAuthtificated == false) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            hasBack: false,
            isHome: false,
            categoryName: 'طلباتى',
          ),
        ),
        // bottomNavigationBar: CustomBottomBar(index: 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("الرجاء تسجيل الدخول برقم هاتفك"),
            ),
            RaisedButton(
              child: Text(" تسجيل الدخول"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Login()),
                );
              },
            )
          ],
        ),
      );
    }
    if (_orders == null)
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            hasBack: false,
            isHome: false,
            categoryName: 'طلباتى',
          ),
        ),
        // bottomNavigationBar: CustomBottomBar(index: 1),
        body: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            backgroundColor: Colors.amber,
          ),
        ),
      );
    return Scaffold(
      backgroundColor: Color(0xfff6f8ff),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: false,
          isHome: false,
          categoryName: 'طلباتى',
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(index: 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: _orders.values.map((value) {
              return Column(
                children: value.map((order) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      // width: deviceWidth * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: deviceWidth * 0.07,
                            height: deviceHeight * 0.01,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'طلب ' + value.last.orderId,
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/product_des_icon.png',
                                    width: deviceWidth * 0.05,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    order.total,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: Color(0xffe5a65f),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.status.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/images/product_car_icon.png',
                                    width: deviceWidth * 0.05,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    order.dateAdded.toString(),
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
