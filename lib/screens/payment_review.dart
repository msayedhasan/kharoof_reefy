import 'package:kharoof_reefy/models/entites/cart.dart';
import 'package:kharoof_reefy/models/entites/order_confirmation_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kharoof_reefy/screens/main_navigation.dart';
import 'package:kharoof_reefy/screens/my_orders.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_bottom_bar.dart';

class PaymentReview extends StatefulWidget {
  final OrderConfirmationData orderConfirmationData;
  final Cart userCart;
  PaymentReview({this.orderConfirmationData, this.userCart});
  @override
  _PaymentReviewState createState() => _PaymentReviewState();
}

class _PaymentReviewState extends State<PaymentReview> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: true,
          isHome: false,
          categoryName: "مراجعة الطلب ",
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(index: 2),
      body: _body(),
    );
  }

  Widget _body() {
    if (widget.orderConfirmationData == null)
      return Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    Widget html = Html(data: """
        ${widget.orderConfirmationData.payment}
      """, blacklistedElements: ["script"]);
    return Center(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Text(
              //     "معلومات الطلب",
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
              OrderDetailsItem(
                  title: "طريقة الدفع",
                  value: widget.orderConfirmationData.paymentCode == "tap"
                      ? r""" الدفع الالكتروني"""
                      : widget.orderConfirmationData.paymentMethod),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: html,
                ),
              ),
              //  OrderDetailsItem(title: "تاريخ التوصيل", value: _orderDetail.),
              // OrderDetailsItem(
              //     title: "العنوان",
              //     value: widget.orderConfirmationData.shippingAddressFormat),
              Column(
                children: widget.orderConfirmationData.totals.map((e) {
                  return OrderDetailsItem(title: e.title, value: e.text);
                }).toList(),
              ),
              //  OrderDetailsItem(title: "تاريخ التوصيل", value: _orderDetail.),
              // OrderDetailsItem(
              //     title: "العنوان",
              //     value: widget.orderConfirmationData.shippingAddressFormat),
              Column(
                children: widget.orderConfirmationData.totals.map((e) {
                  return OrderDetailsItem(title: e.title, value: e.text);
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: loading
                    ? Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : FlatButton(
                        color: Color(0xffe5a65f),
                        child: Text("إنهاء الطلب"),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          var rs = await OpenCartApiService().finishOrder(null);
                          setState(() {
                            loading = false;
                          });
                          if (rs != null) {
                            if (widget.userCart != null) {
                              print(widget.userCart.reward);
                            }

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return MyOrders();
                            //     },
                            //   ),
                            // );
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) {
                                  return MainNavigation(
                                    routeIndex: 1,
                                  );
                                },
                              ),
                              (Route<dynamic> route) => false,
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderDetailsItem extends StatefulWidget {
  final String title;
  final String value;

  const OrderDetailsItem({Key key, this.title, this.value}) : super(key: key);
  @override
  _OrderDetailsItemState createState() => _OrderDetailsItemState();
}

class _OrderDetailsItemState extends State<OrderDetailsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      width: MediaQuery.of(context).size.width,
      height: 46,
      decoration: BoxDecoration(
          border:
              Border.all(width: .5, color: Color(0xffe5a65f).withOpacity(.5)),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: Text(widget.title)),
          Expanded(child: Text(widget.value)),
        ],
      ),
    );
  }
}
