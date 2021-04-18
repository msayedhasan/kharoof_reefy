import 'package:flutter/material.dart';
import 'package:kharoof_reefy/models/product.dart';
import 'package:kharoof_reefy/models/productModel.dart';
import 'package:kharoof_reefy/widgets/products/product_list_item.dart';

class ProductList extends StatefulWidget {
  final List<ProductModel> allProducts;
  ProductList({Key key, @required this.allProducts}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          widget.allProducts.length,
          (index) => ProductListItem(
            currentProduct: widget.allProducts[index],
            imageURL: widget.allProducts[index].image,
            productName: widget.allProducts[index].name,
            productPrice: widget.allProducts[index].priceString,
          ),
        ),
      ),
    );
  }
}
