import 'package:flutter/material.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_app_bar.dart';
import 'package:kharoof_reefy/widgets/app_bars/custom_bottom_bar.dart';
import 'package:kharoof_reefy/widgets/category_grid/category_grid_view.dart';

class SubCategory extends StatefulWidget {
  final String categoryName;
  final String id;
  SubCategory({Key key, @required this.categoryName,@required this.id}):super(key:key);
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f8ff),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(hasBack: true,categoryName: widget.categoryName,isHome: false,)),
      // bottomNavigationBar: CustomBottomBar(index: 0,),
      body: CategoryGridView(id: widget.id,),
    );
  }
}
