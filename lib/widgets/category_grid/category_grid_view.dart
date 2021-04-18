import 'package:flutter/material.dart';
import 'category_grid_item.dart';
import 'package:kharoof_reefy/collection/categories.dart';
import 'package:kharoof_reefy/models/category_model.dart';
import 'package:kharoof_reefy/widgets/category_grid/category_grid_item.dart';

class CategoryGridView extends StatefulWidget {
  final String id;
  CategoryGridView({Key key, @required this.id}) : super(key: key);
  @override
  _CategoryGridViewState createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {
  List<CategoryModel> currentSubCategories = [];

  void getCurrentSubCategories() {
    for (var item in subCategories) {
      if (item.parentID == widget.id) {
        currentSubCategories.add(item);
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

  @override
  void initState() {
    getCurrentSubCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return currentSubCategories.length > 0
        ? GridView.count(
            crossAxisCount: 2,
            children: currentSubCategories.map((e) {
              return CategoryGirdItem(
                mainImage: '${e.image}',
                title: '${e.name}',
                countProducts: e.countProducts,
                id: '${e.id}',
                homeLink: false,
              );
            }).toList(),
          )
        : Center(
            child: Text('لا يوجد منتجات'),
          );
  }
}
