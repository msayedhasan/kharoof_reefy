import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/sizes.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List<Widget> images;
  CarouselSliderWidget({Key key, @required this.images}) : super(key: key);
  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: deviceHeight * 0.30,
        autoPlay: true,
        viewportFraction: 1,
      ),
      items: widget.images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: deviceWidth * 1,
              child: i,
            );
          },
        );
      }).toList(),
    );
  }
}
