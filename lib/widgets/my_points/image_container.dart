import 'package:flutter/material.dart';
import 'package:kharoof_reefy/utils/color.dart';
import 'package:kharoof_reefy/utils/size_config.dart';
class ImageContainer extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final  scale;

  const ImageContainer({Key key, this.path, this.width, this.height, this.scale}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return      Container(
        decoration: BoxDecoration(
            color: points_color,

            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Image.asset('${path}',width:width,height: height,scale: scale==null?1:scale,));





  }
}
