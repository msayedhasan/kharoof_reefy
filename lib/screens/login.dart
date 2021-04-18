import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kharoof_reefy/Utils/session.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/screens/confirm_login.dart';
import 'package:kharoof_reefy/services/auth_service.dart';
import 'package:kharoof_reefy/widgets/error_alert.dart';

import 'dart:math' as math; 

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phoneNumber;
  bool isLoading = false;

  @override
  void initState() {
    _phoneNumber = TextEditingController();
    super.initState();
  }

  _login() async {
    if (_phoneNumber.text != null) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }

      await Session.setSessionLocal();
      var rs = await AuthService.instance.login(_phoneNumber.text);
      print("Call login to send sms opt");
      if (rs == true)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmLogin(
              phoneNumber: _phoneNumber.text,
            ),
          ),
        );
      else
        errorDialog(
          context: context,
          text: "أدخل رقم هاتف صحيح",
        );
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/full_splash_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
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
                            'تسجيل الدخول',
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
                            'من فضلك ادخل رقم الهاتف الخاص بكم',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: deviceWidth * 0.8,
                            child: TextField(
                              controller: _phoneNumber,
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                focusedBorder: new OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffe5a65f),
                                    width: 2,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: _login,
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
                                child: isLoading
                                    ? SpinKitCircle(
                                        color: Color(0xffb09577),
                                        size: 20.0,
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            transform:
                                                Matrix4.rotationY(math.pi),
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
            ],
          ),
        ),
      ),
    );
  }
}
