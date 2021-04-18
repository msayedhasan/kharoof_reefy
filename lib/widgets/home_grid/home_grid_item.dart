import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/models/category_model.dart';
import 'package:kharoof_reefy/screens/products.dart';
import 'package:kharoof_reefy/screens/sub_category.dart';
import 'package:shimmer/shimmer.dart';

class HomeGridItem extends StatefulWidget {
  final String mainImage;
  final String title;
  final bool hasLink;
  final CategoryModel categoryModel;
  HomeGridItem({
    Key key,
    this.categoryModel,
    this.mainImage,
    this.title,
    this.hasLink,
  }) : super(key: key);
  @override
  _HomeGridItemState createState() => _HomeGridItemState();
}

class _HomeGridItemState extends State<HomeGridItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.title == null) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          width: deviceWidth / 2 - 16,
          height: deviceWidth / 2 - 16,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          if (!widget.categoryModel.hasSubCategory) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SubCategory(
                categoryName: widget.title,
                id: widget.categoryModel.id,
              );
            }));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Products(
                  categoryName: widget.categoryModel.name,
                  categoryID: widget.categoryModel.id);
            }));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(4.0),
          width: deviceWidth / 2 - 16,
          height: deviceWidth / 2 - 16,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey[200],
                offset: new Offset(0.0, 0.0),
                blurRadius: 2.0,
                spreadRadius: 1,
              )
            ],
          ),
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
              // Positioned(
              //   bottom: 20,
              //   right: 10,
              //   child: Text(
              //     'يوجد ' + widget.categoryModel.subCategoryNumber + ' منتج',
              //     style: TextStyle(
              //       fontSize: 12,
              //       fontFamily: 'URW_DIN_Arabic_Medium',
              //       color: Colors.grey,
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Text(
                  'يوجد ' + widget.categoryModel.countProducts + ' منتج',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'URW_DIN_Arabic_Medium',
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
