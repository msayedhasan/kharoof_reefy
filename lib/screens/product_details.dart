import 'dart:convert';
import 'dart:ui';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/font_styles.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/models/entites/product_detail.dart';
import 'package:kharoof_reefy/models/options_model.dart';
import 'package:kharoof_reefy/models/productModel.dart';
import 'package:kharoof_reefy/screens/login.dart';
import 'package:kharoof_reefy/services/auth_service.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/product_details/added_to_basket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel currentProduct;

  ProductDetails({Key key, @required this.currentProduct}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String slaughter;
  bool isLoading = true;
  bool _isChecked = false;

  var selectedOptionValue;
  var value = "";

  ProductDetail productDetail;
  BaseService service = OpenCartApiService();

  ProductDetail _product;
  var price;
  var priceTotal;
  int quantity = 1;
  String selectedType;

  var otherOption;
  var options = new Map();
  var optionsValues = new Map();
  bool hasRelated = false;
  var checkList = [];
  DateTime selectedDate;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isAuthtificated = null;

  _isAuthentificated() async {
    var rs = await AuthService.instance.checkAuth();
    setState(() {
      isAuthtificated = rs;
    });
  }

  _displaySnackBar(BuildContext context, {String message}) {
    SnackBar snackBar = SnackBar(
      content: Text(''),
    );
    if (message != null) {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(message),
        ),
      );
    } else {
      snackBar = SnackBar(
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text('يرجى التحقق من خيارات المنتج'),
        ),
      );
    }

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  int finalPrice = 0;
  int currentQuantity = 1;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getProductDetails();
      await _isAuthentificated();
    });
    super.initState();
  }

  double _pricePrice(String price) {
    var _price = price.split(" ")[0];
    if (_price.contains(",")) {
      return double.parse(_price.replaceAll(",", "").trim());
    } else {
      return double.parse(_price..trim());
    }
  }

  _getProductDetails() async {
    var rs = await service.getProductById(widget.currentProduct.id);
    if (rs != null) {
      setState(() {
        _product = rs;
        price = rs.price.toString() + " ر.س ";

        if (rs.minimum != null && rs.minimum != '') {
          quantity = int.parse(rs.minimum);
        }
        // priceTotal = price;
        priceTotal = (_pricePrice(price) * quantity).toString();
      });
    } else {
      print("product null");
    }
  }

  Widget _buildOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _product.options.values.isEmpty
          ? Container()
          : _product.options.values.map((e) {
              return Column(
                children: [_displayOption(e), _getRelatedOption(e)],
              );
            }).toList(),
    );
  }

  Widget _getRelatedOption(Option option) {
    if (optionsValues[option.productOptionId] != null) {
      if (optionsValues[option.productOptionId].toString().contains("_")) {
        var optionValue =
            optionsValues[option.productOptionId].toString().split("_")[1];

        if (option.relatedOptions.isNotEmpty &&
            ((optionValue == "مذبوح") || (optionValue == "نعم"))) {
          return Column(
            children: option.relatedOptions.isEmpty
                ? []
                : option.relatedOptions.map(
                    (e) {
                      Option _op = Option.fromJson(e.toJson());
                      return Wrap(
                        children: [
                          _displayOption(_op),
                          (e.optionValue != null && hasRelated)
                              ? Column(
                                  children: e.optionValue.isEmpty
                                      ? []
                                      : e.optionValue.map((rop) {
                                          Option rOp = Option.fromJson(
                                            rop.toJson(),
                                          );
                                          return _displayOption(rOp);
                                        }).toList(),
                                )
                              : Container()
                        ],
                      );
                    },
                  ).toList(),
          );
        } else
          return Container();
      } else {
        return Container();
      }
    } else
      return Container();
  }

  Widget _displayOption(Option option) {
    switch (option.type) {
      case "select":
        return _dropdownList(option);
      case "radio":
        return _radioList(option);
      case "checkbox":
        return _checkbox(option);
      case "date":
        return _dateField(option);
      case "textarea":
        return _addComment(option);
      case "text":
        return _inputText(option);

      default:
        return Container();
    }
  }

  Widget _dateField(Option option) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DateTimeField(
                // label: option.name,
                selectedDate: selectedDate,
                onDateSelected: (DateTime date) async {
                  setState(() {
                    selectedDate = date;
                    options[option.productOptionId.toString()] =
                        selectedDate.toString();
                  });
                  var val = await OpenCartApiService().producLivePrice(
                      _product.productId.toString(), quantity, options);
                  setState(() {
                    price = val;
                  });
                },
                lastDate: DateTime(2020),
              ),
            ),
            SizedBox(width: 10),
            Text(option.name),
          ],
        ),
      ),
    );
  }

  Widget _checkbox(Option option) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: StatefulCheckboxDialog(
                  header: option.name,
                  checkList: checkList,
                  option: option,
                  options: options,
                  optionsValues: optionsValues,
                  handler: (chList, opts) async {
                    setState(() {
                      checkList = chList;
                      options = opts;
                    });
                    var valp = await OpenCartApiService().producLivePrice(
                      _product.productId.toString(),
                      quantity,
                      options,
                    );
                    setState(() {
                      priceTotal = valp;
                      price =
                          (_pricePrice(valp) / quantity).toString() + " ر.س ";
                    });
                  },
                ),
              );
            },
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(8),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      // fontFamily: "URWDINArabic",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: ConstrainedBox(
    //     constraints: const BoxConstraints(minWidth: double.infinity),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         title(option.name),
    //         Row(
    //           children: option.optionValue.isEmpty
    //               ? []
    //               : option.optionValue.map(
    //                   (e) {
    //                     return Wrap(
    //                       children: [
    //                         Row(
    //                           children: [
    //                             Checkbox(
    //                               checkColor: Colors.greenAccent,
    //                               activeColor: Colors.orange,
    //                               value: checkList.contains(e.name.toString()),
    //                               onChanged: (bool value) async {
    //                                 print(checkList.isEmpty);
    //                                 if (checkList.isEmpty) {
    //                                   setState(() {
    //                                     checkList.add(e.name.toString());
    //                                   });
    //                                 } else if (!checkList
    //                                     .contains(e.name.toString())) {
    //                                   setState(() {
    //                                     checkList.add(e.name.toString());
    //                                   });
    //                                 } else {
    //                                   setState(() {
    //                                     checkList.remove(e.name.toString());
    //                                   });
    //                                 }

    //                                 setState(() {
    //                                   optionsValues[option.productOptionId] =
    //                                       checkList;
    //                                   options[option.productOptionId
    //                                           .toString()] =
    //                                       e.productOptionValueId.toString();
    //                                 });
    //                                 var valp = await OpenCartApiService()
    //                                     .producLivePrice(
    //                                         _product.productId.toString(),
    //                                         quantity,
    //                                         options);
    //                                 setState(() {
    //                                   priceTotal = valp;
    //                                   price = (_pricePrice(valp) / quantity)
    //                                           .toString() +
    //                                       " ر.س ";
    //                                 });
    //                               },
    //                             ),
    //                             Text(
    //                               e.name,
    //                               textAlign: TextAlign.right,
    //                               style: const TextStyle(
    //                                 color: Colors.black,
    //                                 fontWeight: FontWeight.w500,
    //                                 fontFamily: "URWDINArabic",
    //                                 fontStyle: FontStyle.normal,
    //                                 fontSize: 15.0,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         SizedBox(width: 26),
    //                       ],
    //                     );
    //                   },
    //                 ).toList(),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _inputText(Option rOption) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 28, bottom: 6),
      child: TextFormField(
        style: TextStyle(fontSize: 18),
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        onChanged: (value) async {
          setState(() {
            options[rOption.productOptionId.toString()] = value.toString();
          });
          var val = await OpenCartApiService().producLivePrice(
              _product.productId.toString(), quantity, options);
          setState(() {
            price = val;
          });
        },
        decoration: InputDecoration(
          hintText: rOption.name,
          isDense: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey)),
          errorStyle: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget title(String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          // fontFamily: "URWDINArabic",
          fontStyle: FontStyle.normal,
          fontSize: 15.0,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _dropdownList(Option option) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: StatefulRadioDialog(
                  header: option.name,
                  groupValue: optionsValues[option.productOptionId],
                  product: _product,
                  option: option,
                  quantity: quantity,
                  options: options,
                  priceTotal: priceTotal,
                  price: price,
                  pricePrice: _pricePrice,
                  handler: (value) async {
                    optionsValues[option.productOptionId] = value;
                    setState(() {
                      options[option.productOptionId.toString()] =
                          value.toString();
                    });
                    print('handler');
                    print(optionsValues[option.productOptionId]);
                    var val = await OpenCartApiService().producLivePrice(
                      _product.productId.toString(),
                      quantity,
                      options,
                    );

                    setState(() {
                      priceTotal = val;
                      price =
                          (_pricePrice(val) / quantity).toString() + " ر.س ";
                    });
                  },
                ),
              );
            },
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(8),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      // fontFamily: "URWDINArabic",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    option.optionValue.firstWhere(
                                (element) =>
                                    element.productOptionValueId ==
                                    optionsValues[option.productOptionId],
                                orElse: () => null) !=
                            null
                        ? option.optionValue
                            .firstWhere(
                                (element) =>
                                    element.productOptionValueId ==
                                    optionsValues[option.productOptionId],
                                orElse: () => null)
                            .name
                        : '',
                  ),
                ],
              ),
            ),
          ),
          //  DropdownButtonHideUnderline(
          //   child: ButtonTheme(
          //     alignedDropdown: true,
          //     child: DropdownButton(
          //       // icon: Icon(Icons.arrow_back_ios),
          //       hint: Text(
          //         option.name,
          //         style: const TextStyle(
          //           color: Colors.black,
          //           fontWeight: FontWeight.w500,
          //           // fontFamily: "URWDINArabic",
          //           fontStyle: FontStyle.normal,
          //           fontSize: 14.0,
          //         ),
          //       ),

          //       dropdownColor: Colors.white,
          //       isExpanded: true,
          //       value: optionsValues[option.productOptionId],
          //       onChanged: (value) async {
          //         optionsValues[option.productOptionId] = value;
          //         setState(() {
          //           options[option.productOptionId.toString()] =
          //               value.toString();
          //         });

          //         var val = await OpenCartApiService().producLivePrice(
          //           _product.productId.toString(),
          //           quantity,
          //           options,
          //         );

          //         setState(() {
          //           priceTotal = val;
          //           price =
          //               (_pricePrice(val) / quantity).toString() + " ر.س ";
          //         });
          //       },
          //       items: option.optionValue.isEmpty
          //           ? []
          //           : option.optionValue.map((item) {
          //               return DropdownMenuItem(
          //                 value: item.productOptionValueId,
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text(
          //                       item.name,
          //                       style: const TextStyle(
          //                         color: Colors.black,
          //                         fontWeight: FontWeight.w500,
          //                         fontFamily: "URWDINArabic",
          //                         fontStyle: FontStyle.normal,
          //                         fontSize: 15.0,
          //                       ),
          //                       textAlign: TextAlign.right,
          //                     ),
          //                     Text(
          //                       item.price.toString() == "0"
          //                           ? ""
          //                           : item.price.toString(),
          //                       style: const TextStyle(
          //                           color: Colors.black,
          //                           fontWeight: FontWeight.w500,
          //                           // fontFamily: "URWDINArabic",
          //                           fontStyle: FontStyle.normal,
          //                           fontSize: 15.0),
          //                       textAlign: TextAlign.right,
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             }).toList(),
          //     ),
          //   ),
          // ),
        ),
      ],
    );
  }

  Widget _radioList(Option option) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          title(option.name),
          Row(
            children: option.optionValue.isEmpty
                ? []
                : option.optionValue.map((e) {
                    return Wrap(
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(0xffe5a65f),
                              value: e.productOptionValueId.toString() +
                                  "_" +
                                  e.name,
                              groupValue: optionsValues[option.productOptionId],
                              onChanged: (val) async {
                                setState(() {
                                  hasRelated =
                                      val.toString().split("_")[1] == "نعم";
                                  optionsValues[option.productOptionId] =
                                      val.toString();
                                  options[option.productOptionId.toString()] =
                                      e.productOptionValueId.toString();
                                });
                                var valp = await OpenCartApiService()
                                    .producLivePrice(
                                        _product.productId.toString(),
                                        quantity,
                                        options);
                                setState(() {
                                  priceTotal = valp;
                                  price = (_pricePrice(valp) / quantity)
                                          .toString() +
                                      " ر.س ";
                                });
                              },
                            ),
                            Text(
                              e.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                // fontFamily: "URWDINArabic",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        SizedBox(width: 26),
                      ],
                    );
                  }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildText(OptionModel option) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: deviceHeight * 0.2,
        width: deviceWidth * 0.9,
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
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${option.name}',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: deviceWidth * 0.8,
                height: deviceHeight * 0.08,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Color(0xffe5a65f),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addComment(Option option) {
    return Container(
      padding: EdgeInsets.all(8),
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
      child: Column(
        children: [
          title(option.name),
          TextField(
            decoration: InputDecoration(isDense: true),
            textInputAction: TextInputAction.done,
            cursorColor: Color(0xffe5a65f),
            onChanged: (String val) {
              setState(() {
                print(val.toString());
                options[option.productOptionId.toString()] = val.toString();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          hasBack: true,
          categoryName: '${widget.currentProduct.name}',
          isHome: false,
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(index: 0),
      body: _body(),
    );
  }

  _body() {
    return Builder(builder: (_ctx) {
      if (_product == null)
        return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey[200],
                        offset: new Offset(0.0, 0.0),
                        blurRadius: 1.0,
                        spreadRadius: 0.5,
                      )
                    ],
                  ),
                  // height: 118,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[200]),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey[200],
                              offset: new Offset(0.0, 0.0),
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: Image.network(
                          '${_product.image}',
                          width: deviceWidth * 0.23,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${_product.metaTitle}',
                                  style: productMainTitle,
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Wrap(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'assets/images/product_des_icon.png',
                                        width: 16,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      price.toString().contains(" ر.س ")
                                          ? "سعر يبدأ من" +
                                              ' ' +
                                              price.toString()
                                          : "سعر يبدأ من" +
                                              ' ' +
                                              price.toString() +
                                              " ر.س ",
                                      style: productPriceStyle,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  width: 120,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Color(0xfff5f5f4),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  child: _buildQuantity(quantity),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: deviceWidth,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey[200],
                        offset: new Offset(0.0, 0.0),
                        blurRadius: 1.0,
                        spreadRadius: 0.5,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${_product.metaDescription}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                _buildOptions(),
                SizedBox(height: 5),
                _productFooterContainer(),
              ],
            ),
          ),
        ),
      );
    });
  }

  _buildQuantity(qte) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              quantity++;
              priceTotal = (_pricePrice(price) * quantity).toString();
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffe5a65f),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        Text(
          qte.toString() ?? "1",
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        GestureDetector(
          onTap: (_product.minimum != null || _product.minimum != '') &&
                  quantity <= int.parse(_product.minimum)
              ? null
              : () {
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                      priceTotal = (_pricePrice(price) * quantity).toString();
                    });
                  }
                },
          child: Container(
            decoration: BoxDecoration(
              color: (_product.minimum != null || _product.minimum != '') &&
                      quantity <= int.parse(_product.minimum)
                  ? Colors.grey
                  : Color(0xffe5a65f),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Icon(
              Icons.remove,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  _productFooterContainer() {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        // height: deviceHeight * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
              color: Colors.grey[200],
              offset: new Offset(0.0, 0.0),
              blurRadius: 1.0,
              spreadRadius: 0.5,
            )
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'إجمالى السعر',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$priceTotal',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var item = {
                        "product_id": _product.productId.toString(),
                        "quantity": quantity.toString(),
                        "option": options,
                        "options_child_not_required":
                            _product.optionsChildNotRequired
                      };

                      if (isAuthtificated != null && isAuthtificated) {
                        var rs = await OpenCartApiService().addItemToCart(item);

                        if (rs == true) {
                          showDialog(
                              context: context,
                              builder: (_) => AddedToBasket());
                        } else {
                          if (rs is Iterable) {
                            final message = rs.take(1).toList()[0];
                            _displaySnackBar(context,
                                message: message.toString());
                          } else {
                            _displaySnackBar(context);
                          }
                        }
                      } else {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setString(
                          "product_detail",
                          jsonEncode(item),
                        );
                        await alert();
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: deviceWidth * 0.7,
                          height: deviceHeight * 0.05,
                          decoration: BoxDecoration(
                            color: Color(0xffe5a65f),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'اطلب الان',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        Positioned.directional(
                          // right: 50,
                          textDirection: TextDirection.rtl,
                          height: deviceHeight * 0.05,
                          start: 10,
                          child: Icon(
                            Icons.arrow_back,
                            size: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> alert() {
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
}

class StatefulRadioDialog extends StatefulWidget {
  final String header;
  var groupValue;
  final Function handler;
  ProductDetail product;
  Option option;
  int quantity;
  Map<dynamic, dynamic> options;
  dynamic priceTotal;
  dynamic price;
  Function pricePrice;

  StatefulRadioDialog({
    this.header,
    this.groupValue,
    this.handler,
    this.product,
    this.option,
    this.quantity,
    this.options,
    this.priceTotal,
    this.price,
    this.pricePrice,
  });
  @override
  _StatefulRadioDialogState createState() => new _StatefulRadioDialogState();
}

class _StatefulRadioDialogState extends State<StatefulRadioDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.ease);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  var newValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text(
                        widget.header ?? '',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.option.optionValue.isEmpty
                            ? []
                            : widget.option.optionValue.map(
                                (item) {
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              activeColor: Color(0xffe5a65f),
                                              value: item.productOptionValueId,
                                              groupValue: widget.groupValue,
                                              onChanged: (value) async {
                                                widget.groupValue = value;
                                                setState(() {
                                                  widget.options[
                                                          widget.option
                                                              .productOptionId
                                                              .toString()] =
                                                      value.toString();

                                                  newValue = value;
                                                });

                                                print(widget.groupValue);
                                              },
                                            ),
                                            Text(item.name),
                                          ],
                                        ),
                                        Text(
                                          item.price.toString() == "0"
                                              ? ""
                                              : item.price.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            // fontFamily: "URWDINArabic",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                widget.handler(newValue);
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xffe5a65f),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'حفظ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'اغلاق',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatefulCheckboxDialog extends StatefulWidget {
  final String header;
  final Function handler;
  List checkList;
  Option option;
  Map options;
  Map optionsValues;

  StatefulCheckboxDialog({
    this.header,
    this.checkList,
    this.handler,
    this.option,
    this.options,
    this.optionsValues,
  });
  @override
  _StatefulCheckboxDialogState createState() =>
      new _StatefulCheckboxDialogState();
}

class _StatefulCheckboxDialogState extends State<StatefulCheckboxDialog>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.ease);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text(
                        widget.header ?? '',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.option.optionValue.isEmpty
                            ? []
                            : widget.option.optionValue.map(
                                (e) {
                                  return Wrap(
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.white,
                                            activeColor: Colors.orange,
                                            value: widget.checkList.contains(
                                              e.name.toString(),
                                            ),
                                            onChanged: (bool value) async {
                                              if (widget.checkList.isEmpty) {
                                                setState(() {
                                                  widget.checkList
                                                      .add(e.name.toString());
                                                });
                                              } else if (!widget.checkList
                                                  .contains(
                                                      e.name.toString())) {
                                                setState(() {
                                                  widget.checkList
                                                      .add(e.name.toString());
                                                });
                                              } else {
                                                setState(() {
                                                  widget.checkList.remove(
                                                      e.name.toString());
                                                });
                                              }

                                              setState(() {
                                                widget.optionsValues[widget
                                                        .option
                                                        .productOptionId] =
                                                    widget.checkList;
                                                widget.options[widget
                                                        .option.productOptionId
                                                        .toString()] =
                                                    e.productOptionValueId
                                                        .toString();
                                              });
                                            },
                                          ),
                                          Text(
                                            e.name,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "URWDINArabic",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.0,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 26),
                                    ],
                                  );
                                },
                              ).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                widget.handler(
                                  widget.checkList,
                                  widget.options,
                                );
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xffe5a65f),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'حفظ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'اغلاق',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
