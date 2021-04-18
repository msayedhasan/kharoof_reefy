import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/screens/main_navigation.dart';
import 'package:kharoof_reefy/services/auth_service.dart';
import 'package:kharoof_reefy/services/open_cart_service.dart';
import 'package:kharoof_reefy/widgets/error_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:math' as math; // import this

class ConfirmLogin extends StatefulWidget {
  String phoneNumber;
  ConfirmLogin({this.phoneNumber});

  @override
  _ConfirmLoginState createState() => _ConfirmLoginState();
}

class _ConfirmLoginState extends State<ConfirmLogin> {
  bool isLoading;
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  TextEditingController pin5 = TextEditingController();
  TextEditingController pin6 = TextEditingController();

  _confirmCode() async {
    if (pin1.text != null &&
        pin2.text != null &&
        pin3.text != null &&
        pin4.text != null &&
        pin5.text != null &&
        pin6.text != null) {
      var code =
          pin1.text + pin2.text + pin3.text + pin4.text + pin5.text + pin6.text;
      setState(() {
        isLoading = true;
      });
      print(
          "---------------------------Confirmation---------------------------");
      var rs = await AuthService.instance.confirm(code);
      setState(() {
        isLoading = false;
      });
      if (rs) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("loggedIn", true);
        var item = await prefs.getString("product_detail");
        if (item != null) {
          var rs = await OpenCartApiService().addItemToCart(jsonDecode(item));
          if (rs == true) {
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => Home()),
            //     (Route<dynamic> route) => false);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainNavigation()),
                (Route<dynamic> route) => false);
          } else {
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => Home()),
            //     (Route<dynamic> route) => false);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainNavigation()),
                (Route<dynamic> route) => false);
          }
        } else {
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (_ctx) => Home()));
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_ctx) => MainNavigation()));
        }
      } else {
        errorDialog(context: context, text: " رمز التحقق غير صحيح  ");
      }
    } else {
      errorDialog(context: context, text: "أدخل الرمز السري الكامل");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/full_splash_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: 480,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color(0xff3a4340),
                ),
              ),
              Container(
                height: 480,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'تأكيد تسجيل الدخول',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Container(
                            child: Image.asset(
                              'assets/images/country_sheep_logo.png',
                              width: deviceWidth * 0.5,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Text(
                            'من فضلك ادخل الكود المرسل رقم الهاتف',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            '+96655 *******78',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller: pin1,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (_) =>
                                          FocusScope.of(context).nextFocus(),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      maxLength: 1,
                                      buildCounter: (BuildContext context,
                                              {int currentLength,
                                              int maxLength,
                                              bool isFocused}) =>
                                          null,
                                      decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffe5a65f),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller: pin2,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (_) =>
                                          FocusScope.of(context).nextFocus(),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      maxLength: 1,
                                      buildCounter: (BuildContext context,
                                              {int currentLength,
                                              int maxLength,
                                              bool isFocused}) =>
                                          null,
                                      decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffe5a65f),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller: pin3,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly,
                                      ],
                                      maxLength: 1,
                                      buildCounter: (BuildContext context,
                                              {int currentLength,
                                              int maxLength,
                                              bool isFocused}) =>
                                          null,
                                      onChanged: (_) =>
                                          FocusScope.of(context).nextFocus(),
                                      decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffe5a65f),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller: pin4,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (_) =>
                                          FocusScope.of(context).nextFocus(),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      maxLength: 1,
                                      buildCounter: (BuildContext context,
                                              {int currentLength,
                                              int maxLength,
                                              bool isFocused}) =>
                                          null,
                                      decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffe5a65f),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller: pin5,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (_) =>
                                          FocusScope.of(context).unfocus(),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      maxLength: 1,
                                      buildCounter: (BuildContext context,
                                              {int currentLength,
                                              int maxLength,
                                              bool isFocused}) =>
                                          null,
                                      decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffe5a65f),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'إعادة الارسال',
                                  style: TextStyle(color: Color(0xffe5a65f)),
                                ),
                                Text(
                                  '0:59',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: _confirmCode,
                            child: Container(
                              width: deviceWidth * 0.6,
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
                                      'تسجيل الدخول',
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
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 30,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              )
              // // Positioned(
              // //   top: 40,
              // //   right: 130,
              // //   child: Text(
              // //     'تأكيد تسجيل الدخول',
              // //     style: TextStyle(color: Colors.white, fontSize: 18),
              // //   ),
              // // ),
              // // Positioned(
              // //   top: 80,
              // //   right: 110,
              // //   child: Image.asset(
              // //     'assets/images/country_sheep_logo.png',
              // //     width: deviceWidth * 0.5,
              // //   ),
              // // ),
              // // Positioned(
              // //   bottom: 210,
              // //   right: 70,
              // //   child: Text(
              // //     'من فضلك ادخل الكود المرسل رقم الهاتف',
              // //     style: TextStyle(fontSize: 16, color: Colors.white),
              // //   ),
              // // ),
              // // Positioned(
              // //   bottom: 175,
              // //   right: 130,
              // //   child: Text(
              // //     '+96655 *******78',
              // //     style: TextStyle(fontSize: 18, color: Colors.white),
              // //   ),
              // // ),
              // // Positioned(
              // //     bottom: 100,
              // //     right: 15,
              // //     child: SizedBox(
              // //       width: deviceWidth * 0.13,
              // //       child: TextField(
              // //         controller: pin1,
              // //         decoration: new InputDecoration(
              // //           filled: true,
              // //           fillColor: Colors.white,
              // //           border: new OutlineInputBorder(
              // //             borderRadius: const BorderRadius.all(
              // //               const Radius.circular(25.0),
              // //             ),
              // //           ),
              // //         ),
              // //       ),
              // //     )),
              // // Positioned(
              // //     bottom: 100,
              // //     right: 70,
              // //     child: SizedBox(
              // //       width: deviceWidth * 0.13,
              // //       child: TextField(
              // //         controller: pin2,
              // //         decoration: new InputDecoration(
              // //           filled: true,
              // //           fillColor: Colors.white,
              // //           border: new OutlineInputBorder(
              // //             borderRadius: const BorderRadius.all(
              // //               const Radius.circular(25.0),
              // //             ),
              // //           ),
              // //         ),
              // //       ),
              // //     )),
              // // Positioned(
              // //     bottom: 100,
              // //     right: 125,
              // //     child: SizedBox(
              // //       width: deviceWidth * 0.13,
              // //       child: TextField(
              // //         controller: pin3,
              // //         decoration: new InputDecoration(
              // //           filled: true,
              // //           fillColor: Colors.white,
              // //           border: new OutlineInputBorder(
              // //             borderRadius: const BorderRadius.all(
              // //               const Radius.circular(25.0),
              // //             ),
              // //           ),
              // //         ),
              // //       ),
              // //     )),
              // // Positioned(
              // //     bottom: 100,
              // //     right: 200,
              // //     child: SizedBox(
              // //       width: deviceWidth * 0.13,
              // //       child: TextField(
              // //         controller: pin4,
              // //         decoration: new InputDecoration(
              // //           filled: true,
              // //           fillColor: Colors.white,
              // //           border: new OutlineInputBorder(
              // //             borderRadius: const BorderRadius.all(
              // //               const Radius.circular(25.0),
              // //             ),
              // //           ),
              // //         ),
              // //       ),
              // //     )),
              // // Positioned(
              // //     bottom: 100,
              // //     right: 255,
              // //     child: SizedBox(
              // //       width: deviceWidth * 0.13,
              // //       child: TextField(
              // //         controller: pin5,
              // //         decoration: new InputDecoration(
              // //           filled: true,
              // //           fillColor: Colors.white,
              // //           border: new OutlineInputBorder(
              // //             borderRadius: const BorderRadius.all(
              // //               const Radius.circular(25.0),
              // //             ),
              // //           ),
              // //         ),
              // //       ),
              // //     )),
              // // Positioned(
              // //     bottom: 100,
              // //     right: 310,
              // //     child: SizedBox(
              // //       width: deviceWidth * 0.13,
              // //       child: TextField(
              // //         controller: pin6,
              // //         decoration: new InputDecoration(
              // //           filled: true,
              // //           fillColor: Colors.white,
              // //           border: new OutlineInputBorder(
              // //             borderRadius: const BorderRadius.all(
              // //               const Radius.circular(25.0),
              // //             ),
              // //           ),
              // //         ),
              // //       ),
              // //     )),
              // // Positioned(
              // //     bottom: 30,
              // //     right: 75,
              // //     child: GestureDetector(
              // //       onTap: _confirmCode,
              // //       child: Container(
              // //         width: deviceWidth * 0.6,
              // //         height: deviceHeight * 0.08,
              // //         decoration: BoxDecoration(
              // //             color: Color(0xffe5a65f),
              // //             borderRadius: BorderRadius.all(Radius.circular(25))),
              // //         child: Center(
              // //             child: Text(
              // //           'تسجيل الدخول',
              // //           style: TextStyle(fontSize: 14, color: Colors.white),
              // //         )),
              // //       ),
              // //     )),
            ],
          ),
        ),
      ),
    );
  }
}
