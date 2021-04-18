import 'package:flutter/material.dart';
import 'package:kharoof_reefy/utils/color.dart';
import 'package:kharoof_reefy/utils/my_padding.dart';
import 'package:kharoof_reefy/utils/size_config.dart';
import 'package:kharoof_reefy/utils/text_style.dart';
import 'package:kharoof_reefy/widgets/my_points/image_container.dart';

class CardPointShape extends StatefulWidget {
  String point;
  CardPointShape({this.point});
  @override
  _CardPointShapeState createState() => _CardPointShapeState();
}

class _CardPointShapeState extends State<CardPointShape> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
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
          padding: PADDING_symmetric(horizontalFactor: 4, verticalFactor: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.point,
                style: TX_STYLE_white_16.copyWith(
                    color: points_color, fontSize: SizeConfig.fontSize20),
              ),
              ImageContainer(
                path: 'assets/images/trophy.png',
                width: SizeConfig.screenWidth * 0.2,
                height: SizeConfig.screenHeight * 0.1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
