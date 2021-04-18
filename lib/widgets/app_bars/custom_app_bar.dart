import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/font_styles.dart';
import 'package:kharoof_reefy/consts/sizes.dart';

class CustomAppBar extends StatefulWidget {
  final String categoryName;
  final bool hasBack;
  final bool isHome;
  CustomAppBar(
      {Key key,
      @required this.isHome,
      @required this.hasBack,
      this.categoryName})
      : super(key: key);
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      // height: deviceHeight * 0.18,
      decoration: BoxDecoration(
        color: Color(0xff515b56),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.hasBack
                  ? IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Color(0xffb09577),
                      ),
                    )
                  : !widget.isHome
                      ? Container(width: 40, height: 1)
                      : Container(),
              widget.categoryName != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${widget.categoryName}',
                        style: subCategoryHeaderTitle,
                      ),
                    )
                  : Container(),
              widget.isHome
                  ? Container(
                      width: deviceWidth,
                      child: Center(
                        child: Image.asset(
                          // 'assets/images/header_logo.png',
                          'assets/images/countrysheep_logo_text.png',
                          height: 60,
                        ),
                      ),
                    )
                  : Image.asset(
                      'assets/images/main_logo.png',
                      width: 75,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
