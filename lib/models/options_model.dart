import 'package:kharoof_reefy/models/option_value_model.dart';

class OptionModel{
  int id;
  String name;
  String type;
  bool required = false;
  List<OptionValueModel> optionValue =[];

  OptionModel({this.id, this.name, this.type, this.required,
      this.optionValue});
}