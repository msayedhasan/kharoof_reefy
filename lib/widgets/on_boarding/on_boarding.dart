import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/sizes.dart';

class OnBoarding extends StatelessWidget {
  final String title;
  final String content;
  final int currentIndex;
  final Function handler;

  const OnBoarding({
    this.content,
    this.title,
    this.currentIndex,
    this.handler,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/full_splash_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/side_ribbon.png',
                  width: deviceWidth * 0.3,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 60,
                  bottom: 30,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    // 'assets/images/splash_logo.png',
                    'assets/images/countrysheep_splash_logo.png',

                    width: deviceWidth * 0.65,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: Stack(
                //clipBehavior: Clip.none,
                children: [
                  Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    child: Image.asset(
                      'assets/images/down_ribbon.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: deviceHeight,
                    width: deviceWidth,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Wrap(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Container(
                            width: deviceWidth * 0.6,
                            child: Image.asset(
                              'assets/images/splash_sheep.png',
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: deviceWidth * 0.7,
                            alignment: Alignment.center,
                            child: Text(
                              '$title',
                              style: TextStyle(
                                color: Color(0xffb6a68b),
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'URW_DIN_Arabic_Medium',
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: deviceWidth * 0.7,
                            child: Text(
                              '$content',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffb6a68b),
                                fontFamily: 'URW_DIN_Arabic_Medium',
                                height: 1.5,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Color(0xffb6a68b),
                              child: Text(
                                currentIndex != 1 ? 'التالى' : 'تخطى',
                                style: TextStyle(
                                  color: Color(0xff4b5652),
                                  fontSize: 14,
                                  fontFamily: 'URW_DIN_Arabic_Medium',
                                ),
                              ),
                              onPressed: handler,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

/*
                  Positioned(
                      bottom: deviceHeight * 0.01,
                      left: deviceWidth * 0.4,
                      child: Container(
                        width: deviceWidth * 0.3,
                        child: RaisedButton(
                          color: Color(0xffb6a68b),
                          child: Text('تخطى',style: TextStyle(color: Color(0xff4b5652),fontSize: 14,fontFamily: 'URW_DIN_Arabic_Medium'),),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return Home();
                            }));
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      )
                  ),
*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
