import 'package:flutter/material.dart';
import 'package:kharoof_reefy/models/entites/account.dart';
import 'package:kharoof_reefy/utils/color.dart';
import 'package:kharoof_reefy/utils/my_padding.dart';
import 'package:kharoof_reefy/utils/size_config.dart';
import 'package:kharoof_reefy/utils/text_style.dart';

class PointsEarnedShape extends StatefulWidget {
  List<Reward> rewards;
  PointsEarnedShape({this.rewards});
  @override
  _PointsEarnedShapeState createState() => _PointsEarnedShapeState();
}

class _PointsEarnedShapeState extends State<PointsEarnedShape> {
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
          padding: PADDING_symmetric(horizontalFactor: 2, verticalFactor: 1),
          child: Column(
            children: widget.rewards.map((r) {
              return Column(
                children: [
                  row_shape(r.points.toString(), r.dateAdded),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
    ;
  }

  row_shape(String points, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        container_shape(points),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "نقاط مكتسبة من اخر معاملة",
              style: TX_STYLE_black_14,
            ),
            SizedBox(height: 5),
            Text(
              date,
              style: TX_STYLE_black_13.copyWith(color: gray),
            ),
          ],
        ),
      ],
    );
  }

  container_shape(String points) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: points_color,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Center(
        child: Text(
          points,
          style: TX_STYLE_white_16.copyWith(fontSize: SizeConfig.fontSize14),
        ),
      ),
    );
  }
}
