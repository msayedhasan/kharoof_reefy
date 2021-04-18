import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/sizes.dart';

class CustomBottomBar extends StatefulWidget {
  Function handler;
  final int index;
  CustomBottomBar({
    Key key,
    @required this.index,
    this.handler,
  }) : super(key: key);
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(deviceWidth * 0.05, 0, deviceWidth * 0.05, 0),
      child: Container(
        height: deviceHeight * 0.1,
        decoration: BoxDecoration(
          color: Color(0xff515b56),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  widget.handler(3);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) {
                  //     return More();
                  //   }),
                  // );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/more_icon.png',
                      width: deviceWidth * 0.05,
                      color: widget.index == 3
                          ? Color(0xffe5a65f)
                          : Color(0xffe0e0e0),
                    ),
                    Text(
                      'المزيد',
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.index == 3
                            ? Color(0xffe5a65f)
                            : Color(0xffe0e0e0),
                        fontFamily: 'URW_DIN_Arabic_Medium',
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  widget.handler(2);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) {
                  //     return CartPage();
                  //   }),
                  // );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.index == 2
                        ? Image.asset(
                            'assets/images/cart_icon_picked.png',
                            width: deviceWidth * 0.05,
                          )
                        : Image.asset(
                            'assets/icons/basket_icon.png',
                            width: deviceWidth * 0.05,
                          ),
                    Text(
                      'السلة',
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.index == 2
                            ? Color(0xffe5a65f)
                            : Color(0xffe0e0e0),
                        fontFamily: 'URW_DIN_Arabic_Medium',
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  widget.handler(1);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) {
                  //     return Login();
                  //   }),
                  // );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/my_orders_icon.png',
                      width: deviceWidth * 0.05,
                      color: widget.index == 1
                          ? Color(0xffe5a65f)
                          : Color(0xffe0e0e0),
                    ),
                    Text(
                      'طلباتى',
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.index == 1
                            ? Color(0xffe5a65f)
                            : Color(0xffe0e0e0),
                        fontFamily: 'URW_DIN_Arabic_Medium',
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  widget.handler(0);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) {
                  //     return Home();
                  //   }),
                  // );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.index == 0
                        ? Image.asset(
                            'assets/icons/home_icon.png',
                            width: deviceWidth * 0.05,
                          )
                        : Image.asset(
                            'assets/icons/home_icon_not_selected.png',
                            width: deviceWidth * 0.05,
                          ),
                    Text(
                      'الرئيسية',
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.index == 0
                            ? Color(0xffe5a65f)
                            : Color(0xffe0e0e0),
                        fontFamily: 'URW_DIN_Arabic_Medium',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
