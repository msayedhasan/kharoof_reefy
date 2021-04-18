import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/screens/on_board.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return OnBoard();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        color: Color(0xff3a4340),
        child: Stack(
          children: [
            Center(
              child: Container(
                height: deviceHeight,
                width: deviceWidth * 0.6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      // 'assets/images/loading_logo.png',
                      'assets/images/countrysheep.png',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: deviceHeight / 4,
              child: Container(
                width: deviceWidth,
                child: Center(
                  child: SpinKitCircle(
                    color: Color(0xffb09577),
                    size: 50.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
