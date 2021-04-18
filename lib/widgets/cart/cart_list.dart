import 'package:flutter/material.dart';
import 'package:kharoof_reefy/models/entites/cart.dart';
import './cart_list_item.dart';

class CartList extends StatefulWidget {
  final List<Product> allProducts;
  CartList({Key key, @required this.allProducts}) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          children: widget.allProducts.map((singleProduct) {
            return CartListItem(
              imageURL: singleProduct.thumb,
              productName: singleProduct.name,
              productPrice: singleProduct.price,
              productQuantity: singleProduct.quantity,
              productKey: singleProduct.key,
            );
          }).toList(),
        ),
      ),
    );
  }
}
