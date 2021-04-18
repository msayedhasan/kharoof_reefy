import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/models/entites/account.dart';
import 'package:kharoof_reefy/models/entites/address.dart';
import 'package:kharoof_reefy/models/entites/cart.dart';
import 'package:kharoof_reefy/models/entites/city.dart';
import 'package:kharoof_reefy/models/entites/order_confirmation_data.dart';
import 'package:kharoof_reefy/models/entites/shipping_payment_method.dart';
import 'package:kharoof_reefy/models/entites/zone.dart';
import 'package:kharoof_reefy/screens/main_navigation.dart';
import 'package:kharoof_reefy/screens/payment_review.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';
import 'package:kharoof_reefy/utils/color.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_bottom_bar.dart';
import 'package:kharoof_reefy/widgets/location_picker.dart';
import "package:latlong/latlong.dart" as latLng;

/// PayTabs
import 'package:flutter_paytabs_bridge_emulator/flutter_paytabs_bridge_emulator.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<dynamic> result = List();
  Address address = Address();
  String selectedZone;
  String city_id;
  String district;
  String city_name;
  String district_name;
  double choseLat, choseLng;
  LatLng latLng;
  bool isLoading = false;
  bool pmLoading = false;
  bool daysLoading = false;
  var selectedDay;
  var _pickedLocation;
  dynamic pt_result;

  ShippingAndPaymentMethed shippingAndPaymentMethed;
  PaymentMethod paymentMethod;
  List<PaymentMethod> paymentMethodList = [];
  OrderConfirmationData orderConfirmationData;
  Cart userCart;

  bool checkout_proccessing = false;

  _displaySnackBar(BuildContext context, String txt, {Color color}) {
    final snackBar = SnackBar(
      backgroundColor: color ?? Colors.redAccent,
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(txt),
      ),
    );
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();

    getAccount();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getCart();
      _getPaymentMethods();
      _getCheckoutData();
    });
  }

  Account account;
  getAccount() async {
    var parsedAccount = await OpenCartApiService().getAccount();
    if (parsedAccount != null) {
      setState(() {
        account = parsedAccount;
      });
    } else {
      print("account null");
    }
  }

  _getCart() async {
    var rs = await OpenCartApiService().getCart();
    if (rs != null) {
      setState(() {
        userCart = rs;
      });
    }
  }

  var generateCheckoutData;
  _getCheckoutData() async {
    setState(() {
      daysLoading = true;
    });
    generateCheckoutData = await OpenCartApiService().generateCheckoutData();
    setState(() {
      daysLoading = false;
    });
  }

  _getPaymentMethods() async {
    var val = await OpenCartApiService().getPaymentMethods();
    if (val != null && val.isNotEmpty) {
      setState(() {
        paymentMethodList = val;
        paymentMethod = val.first;
      });
    }
  }

  Future<void> orderConfirmation() async {
    if (paymentMethod != null) {
      setState(() {
        checkout_proccessing = true;
      });
      var py = await OpenCartApiService().setPaymentMethod(paymentMethod.code);
      if (py != null) {
        await OpenCartApiService().setShippingMethod("");
        var result = await OpenCartApiService().orderConfirm(null);
        setState(() {
          checkout_proccessing = false;
        });
        if (result != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
            return PaymentReview(
              orderConfirmationData: result,
              userCart: userCart,
            );
          }));
        } else {
          setState(() {
            checkout_proccessing = false;
          });
          _displaySnackBar(context, "يرجى تحديد طريقة الدفع الخاصة بك");
        }
      } else {
        setState(() {
          checkout_proccessing = false;
        });
        _displaySnackBar(context, "يرجى تحديد طريقة الدفع الخاصة بك");
      }
    } else {
      setState(() {
        checkout_proccessing = false;
      });
      _displaySnackBar(context, "يرجى تحديد طريقة الدفع الخاصة بك");
    }
  }

  Future getLocationWithNominatim() async {
    Map locationPickerData = await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: UserLocationPicker(
              searchHint: 'ابحث عن مكان',
              awaitingForLocation: "...",
            ),
          );
        });
    if (locationPickerData != null) {
      print("Nomination");
      setState(() {
        _pickedLocation = locationPickerData;
        address.position = _pickedLocation["latlng"];
      });
    } else {
      return;
    }
  }

  Future goToLocationScreen() async {
    getLocationWithNominatim();
  }

  days() {
    List days = generateCheckoutData != null
        ? generateCheckoutData['data']['days']
        : [];
    if ((daysLoading) || days == null || days.length == 0) return Container();
    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: deviceWidth,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(color: Colors.grey[300]),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('اختر يوم التوصيل'),
                      value: selectedDay != null ? selectedDay['id'] : null,
                      onChanged: (value) {
                        setState(() {
                          selectedDay = days.firstWhere(
                            (element) => element['id'] == value,
                            orElse: () => null,
                          );
                        });
                      },
                      items: days.map((day) {
                        return DropdownMenuItem(
                          value: day['id'].toString(),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: [
                                Container(
                                  child: Text(day['name']),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              // Radio(
              //   value: day['id'],
              //   groupValue: selectedDay != null
              //       ? selectedDay['id']
              //       : days[0]['id'],
              //   onChanged: (val) async {
              //     setState(() {
              //       selectedDay = days.firstWhere(
              //         (element) => element['id'] == val,
              //         orElse: () => null,
              //       );
              //     });
              //   },
              // ),
              // Expanded(
              //   child: Text(
              //     day['name'],
              //     style: TextStyle(fontSize: 15),
              //   ),
              // ),
              //   ],
              // ),
              //   );
              // }).toList(),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userCart == null)
      return Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: background_color,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: true,
          isHome: false,
          categoryName: 'الشحن',
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(index: 2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: deviceWidth * 0.9,
                  child: Text(
                    'ادخل عنوان التوصيل',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
            ),
            Container(
              width: deviceWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            address.name = value;
                          });
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          fillColor: Colors.white,
                          hintText: 'اسم المستلم',
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
                    SizedBox(height: 10),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onChanged: (value) {
                          address.telephone = value;
                        },
                        initialValue: account != null ? account.telephone : '',
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          fillColor: Colors.white,
                          hintText: 'رقم الجوال',
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
                    SizedBox(height: 10),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        width: deviceWidth,
                        child: _regionDropdownList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    selectedZone != null
                        ? Directionality(
                            textDirection: TextDirection.rtl,
                            child: selectedZone != null
                                ? Container(
                                    width: deviceWidth,
                                    child: _selectCity(),
                                  )
                                : Container(),
                          )
                        : Container(),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        onSubmitted: (value) => setState(() {
                          address.customField = value;
                        }),
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          fillColor: Colors.white,
                          hintText: 'أقرب معلم لك',
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
                    daysLoading
                        ? Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          )
                        : generateCheckoutData != null
                            ? days()
                            : Container(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: goToLocationScreen,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xffe5a65f),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _pickedLocation != null
                                    ? _pickedLocation["state"]
                                    : 'إختر موقعك من على الخريطة',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pmLoading
                ? Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : _paymentMethods(paymentMethodList),
            SizedBox(height: 10.0),
            Container(
              width: deviceWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    userCart == null
                        ? Container()
                        : Column(
                            children: userCart.totals != null
                                ? userCart.totals.map((e) {
                                    if (e.title != 'تكلفة ثابتة للشحن' &&
                                        e.title != 'الاجمالي النهائي') {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                e.title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                e.text,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }).toList()
                                : [],
                          ),
                    SizedBox(height: 10.0),
                    checkout_proccessing
                        ? Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          )
                        : paymentMethod?.code == "paytabs_creditcard"
                            ? _onlinePayment(context)
                            : _placeOrder(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _placeOrder(ctx) {
    return GestureDetector(
      child: Container(
        width: deviceWidth * 0.6,
        height: deviceHeight * 0.06,
        child: RaisedButton(
          onPressed: () async {
            try {
              setState(() {
                checkout_proccessing = true;
              });
              if (address.telephone == null && account.telephone != null) {
                address.telephone = account.telephone;
              }
              print('step 2');
              var setAddress =
                  await OpenCartApiService().setNewAddress(address);
              if (setAddress['error'] != null &&
                  setAddress['error'].length > 0) {
                setState(() {
                  checkout_proccessing = false;
                });
                return _displaySnackBar(ctx, setAddress['error'][0]);
              }
              print('step 3');
              var setShippingMethod =
                  await OpenCartApiService().setShippingMethod(
                generateCheckoutData['data']['shipping'][0]['quote'][0]['code'],
              );
              if (setShippingMethod['error'] != null &&
                  setShippingMethod['error'].length > 0) {
                setState(() {
                  checkout_proccessing = false;
                });
                return _displaySnackBar(ctx, setShippingMethod['error'][0]);
              }

              print('step 4');
              var setPaymentMethod = await OpenCartApiService()
                  .setPaymentMethod(paymentMethod.code);
              if (setPaymentMethod['error'] != null &&
                  setPaymentMethod['error'].length > 0) {
                setState(() {
                  checkout_proccessing = false;
                });
                return _displaySnackBar(ctx, setPaymentMethod['error'][0]);
              }

              if (selectedDay == null) {
                setState(() {
                  selectedDay = generateCheckoutData['data']['days'][0];
                });
              }
              print('step 5');
              var selectDay =
                  await OpenCartApiService().selectDay(selectedDay['id']);
              if (selectDay['error'] != null && selectDay['error'].length > 0) {
                setState(() {
                  checkout_proccessing = false;
                });
                return _displaySnackBar(ctx, selectDay['error'][0]);
              }

              print('step 6');
              var orderConfirm = await OpenCartApiService().orderConfirm(
                generateCheckoutData['data']['shipping'][0]['quote'][0]['code'],
              );
              // var orderConfirm = await OpenCartApiService().orderConfirm(null);
              if (orderConfirm['error'] != null &&
                  orderConfirm['error'].length > 0) {
                setState(() {
                  checkout_proccessing = false;
                });
                return _displaySnackBar(ctx, orderConfirm['error'][0]);
              }

              if (orderConfirm != null) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) {
                  return PaymentReview(
                    orderConfirmationData: OrderConfirmationData.fromJson(
                      orderConfirm['data'],
                    ),
                    userCart: userCart,
                  );
                }));
              }

              // print('step 7');
              // var forPaymentByUsingWebView =
              //     await OpenCartApiService().forPaymentByUsingWebView();

              // print(forPaymentByUsingWebView);
              // if (forPaymentByUsingWebView['error'] != null &&
              //     forPaymentByUsingWebView['error'].length > 0) {
              //   setState(() {
              //     checkout_proccessing = false;
              //   });
              //   return _displaySnackBar(
              //       ctx, forPaymentByUsingWebView['error'][0]);
              // }

              // print('step 8');
              // var finishOrder = await OpenCartApiService().finishOrder(
              //   generateCheckoutData['data']['shipping'][0]['quote'][0]['code'],
              // );
              // print(finishOrder);
              // if (finishOrder['error'] != null &&
              //     finishOrder['error'].length > 0) {
              //   setState(() {
              //     if (mounted) {
              //       checkout_proccessing = false;
              //     }
              //   });
              //   return _displaySnackBar(ctx, finishOrder['error'][0]);
              // }
              setState(() {
                if (mounted) {
                  checkout_proccessing = false;
                }
              });
              _displaySnackBar(ctx, 'تم بنجاح', color: Colors.green);

              await Future.delayed(Duration(seconds: 3));
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return MainNavigation(
              //         routeIndex: 0,
              //       );
              //     },
              //   ),
              //   (Route<dynamic> route) => false,
              // );

              // /// Set Payment And Shipping Method And Confirm Order
              // await orderConfirmation();
            } catch (err) {
              print(err);
              if (mounted) {
                setState(() {
                  checkout_proccessing = false;
                });
              }
            }
          },
          color: Color(0xffe5a65f),
          child: Text(
            'الدفع',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
        ),
      ),
    );
  }

  _onlinePayment(ctx) {
    return GestureDetector(
      child: Container(
        width: deviceWidth * 0.6,
        height: deviceHeight * 0.06,
        child: RaisedButton(
          onPressed: () async {
            setState(() {
              checkout_proccessing = true;
            });

            ///Save user shiping address
            if (address != null) {
              var rs = await OpenCartApiService().createAddress(address);
              if (rs != null) {
                await OpenCartApiService().setShippingAddress(rs);
              } else {
                setState(() {
                  checkout_proccessing = false;
                });
                _displaySnackBar(ctx, "عنوان خاطئ");
                return;
              }
            } else {
              setState(() {
                checkout_proccessing = false;
              });
              _displaySnackBar(ctx, "عنوان خاطئ");
              return;
            }
            if (mounted)
              setState(() {
                checkout_proccessing = true;
              });

            var args = {
              pt_merchant_email: "ashrafhesham126@gmail.com",
              pt_secret_key:
                  "dL7Jn0P8Sxu6GYdLNFS80sTeONccvQcCmzb5Fs24KOxBjy2T8MfnC0zePkRPRriXHeXX4N7ojfQ3DTSrM4wXM298yCRIHpljoOL6", // Add your Secret Key Here
              pt_transaction_title: "Order payment " + userCart.total ?? "",
              pt_amount: userCart.totalRaw.toString() ?? "0.0",
              pt_currency_code: "SAR",
              pt_customer_email: "user@kharoof_reefy.com",
              pt_customer_phone_number: address.telephone ?? "+96600000000",
              pt_order_id: "-----",
              product_name: "-----",
              pt_timeout_in_seconds: "300", //Optional
              pt_address_billing: address?.zoneId,
              pt_city_billing: "Riyad",
              pt_state_billing: "---",
              pt_country_billing: "SA",
              pt_postal_code_billing: "00966",
              pt_address_shipping: address?.zoneId ?? "",
              pt_city_shipping: "Riyad",
              pt_state_shipping: "---",
              pt_country_shipping: "SA",
              pt_postal_code_shipping:
                  "00966", //Put Country Phone code if Postal
              pt_color: "#375577",
              pt_language: 'ar', // 'en', 'ar'
              pt_tokenization: true,
              pt_preauth: false,
              pt_merchant_region: 'saudi'
            };

            if (paymentMethod != null) {
              setState(() {
                checkout_proccessing = true;
              });
              var py = await OpenCartApiService()
                  .setPaymentMethod(paymentMethod.code);
              if (py != null) {
                await OpenCartApiService().setShippingMethod("");

                /// Hold Online Payment
                await FlutterPaytabsSdk.startPayment(args, (event) async {
                  print(event);
                  List<dynamic> eventList = event;
                  Map firstEvent = eventList.first;
                  if (firstEvent.keys.first == "EventPreparePaypage") {
                    //_result = firstEvent.values.first.toString();
                  } else {
                    pt_result = firstEvent["pt_result"].toString();

                    if (pt_result == "Approved") {
                      var result =
                          await OpenCartApiService().orderConfirm(null);

                      checkout_proccessing = false;

                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (ctx) {
                        return PaymentReview(
                          orderConfirmationData: result,
                          userCart: userCart,
                        );
                      }));
                    } else {
                      _displaySnackBar(ctx, "عملية الدفع فشلت");
                    }
                  }
                });
              } else {
                setState(() {
                  checkout_proccessing = false;
                });
                _displaySnackBar(context, "يرجى تحديد طريقة الدفع الخاصة بك");
              }
            } else {
              setState(() {
                checkout_proccessing = false;
              });
              _displaySnackBar(context, "يرجى تحديد طريقة الدفع الخاصة بك");
            }

            print("order total : " + userCart.totalRaw.toString());

            print("Online payments");

            if (mounted) {
              setState(() {
                checkout_proccessing = false;
              });
            }
          },
          color: Color(0xffe5a65f),
          child: Text(
            'Online Payment',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
        ),
      ),
    );
  }

  _paymentMethods(List<PaymentMethod> paymentList) {
    if ((pmLoading) || paymentList == null) return Container();
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Center(
              child: Container(
                width: deviceWidth * 0.9,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'إختر طريقة الدفع',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 19),
                ),
              ),
            ),
          ),
          Container(
            width: deviceWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: paymentList.map((pm) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Radio(
                          value: pm,
                          groupValue: paymentMethod,
                          onChanged: (val) async {
                            setState(() {
                              paymentMethod = pm;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            pm.title.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _regionDropdownList() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Colors.grey[300]),
      ),
      child: DropdownButtonHideUnderline(
        child: FutureBuilder<List<Zone>>(
          future: OpenCartApiService().getCountryZone(),
          builder: (ctx, _snap) {
            if (!_snap.hasData)
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );

            return DropdownButton(
              hint: Text('المدينة'),
              value: selectedZone,
              onChanged: (value) {
                setState(() {
                  selectedZone = value;
                  address.zone = selectedZone;
                  address.zoneId = selectedZone;
                });
              },
              items: _snap.data.map((item) {
                return DropdownMenuItem(
                  value: item.zoneId,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 13,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            item.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _selectCity() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Colors.grey[300]),
      ),
      child: DropdownButtonHideUnderline(
        child: FutureBuilder<List<City>>(
          future: OpenCartApiService().getZoneCities(selectedZone),
          builder: (ctx, _snap) {
            if (!_snap.hasData)
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );

            return DropdownButton<String>(
              hint: Text('محافظة'),
              value: city_id,
              onChanged: (value) {
                setState(() {
                  city_id = value;
                  address.cityId = city_id;
                });
              },
              items: _snap.data.map((item) {
                return DropdownMenuItem(
                  value: item.cityId,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 13,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
