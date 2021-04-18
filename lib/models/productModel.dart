import 'package:kharoof_reefy/models/options_model.dart';

class ProductModel{
  int id;
  String name;
  String image;
  int priceInt;
  String priceString;
  String description;
  List<OptionModel> options = [];

  ProductModel({this.id, this.name, this.image, this.priceInt, this.priceString,
      this.description, this.options});
}