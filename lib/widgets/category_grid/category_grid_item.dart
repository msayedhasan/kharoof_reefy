import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/screens/products.dart';
import 'package:kharoof_reefy/screens/sub_category.dart';

class CategoryGirdItem extends StatefulWidget {
  final String mainImage;
  final String title;
  final String countProducts;
  final String id;
  final bool homeLink;
  CategoryGirdItem(
      {Key key,
      @required this.mainImage,
      @required this.title,
      this.countProducts,
      @required this.homeLink,
      @required this.id})
      : super(key: key);
  @override
  _CategoryGirdItemState createState() => _CategoryGirdItemState();
}

class _CategoryGirdItemState extends State<CategoryGirdItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Products(categoryName: widget.title, categoryID: widget.id);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          width: deviceWidth * 0.42,
          height: deviceHeight * 0.2,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  widget.mainImage,
                  width: deviceWidth * 0.18,
                  height: deviceHeight * 0.08,
                ),
              ),
              Positioned(
                right: 10,
                top: 20,
                child: Container(
                  height: 9,
                  width: deviceWidth * 0.10,
                  decoration: BoxDecoration(
                    color: Color(0xffe5a65f),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
              ),
              Positioned(
                  bottom: 2,
                  left: 3,
                  child: Image.asset(
                    'assets/images/home_card_mark.png',
                    width: deviceWidth * 0.12,
                  )),
              Positioned(
                bottom: 40,
                right: 25,
                child: Text(
                  '${widget.title}',
                  style: TextStyle(
                      fontSize: 19, fontFamily: 'URW_DIN_Arabic_Medium'),
                ),
              ),
              Positioned(
                  bottom: 20,
                  right: 10,
                  child: Text(
                    'يوجد ${widget.countProducts} منتج',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'URW_DIN_Arabic_Medium',
                        color: Colors.grey),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
