import 'package:flutter/material.dart';
import 'package:kharoof_reefy/collection/categories.dart';
import 'package:kharoof_reefy/widgets/home_grid/home_grid_item.dart';

class HomeGridView extends StatefulWidget {
  @override
  _HomeGridViewState createState() => _HomeGridViewState();
}

class _HomeGridViewState extends State<HomeGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: allCategories.map((singleCategory) {
          return HomeGridItem(
            mainImage: singleCategory.image,
            title: singleCategory.name,
            hasLink: true,
            categoryModel: singleCategory,
          );
        }).toList());
  }
}
