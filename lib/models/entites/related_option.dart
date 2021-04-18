// import 'dart:convert';

// import 'package:ehtzem/Models/product_detail.dart';

// RelatedOption relatedOptionFromJson(String str) =>
//     RelatedOption.fromJson(json.decode(str));

// String relatedOptionToJson(RelatedOption data) => json.encode(data.toJson());

// class RelatedOption {
//   RelatedOption({
//     this.productOptionId,
//     this.optionValue,
//     this.optionId,
//     this.name,
//     this.type,
//     this.value,
//     this.required,
//   });

//   int productOptionId;
//   List<OptionOptionValue> optionValue;
//   int optionId;
//   String name;
//   String type;
//   String value;
//   String required;

//   factory RelatedOption.fromJson(Map<String, dynamic> json) => RelatedOption(
//         productOptionId: json["product_option_id"],
//         optionValue: List<OptionOptionValue>.from(
//             json["option_value"].map((x) => OptionOptionValue.fromJson(x))),
//         optionId: json["option_id"],
//         name: json["name"],
//         type: json["type"],
//         value: json["value"],
//         required: json["required"],
//       );

//   Map<String, dynamic> toJson() => {
//         "product_option_id": productOptionId,
//         "option_value": List<dynamic>.from(optionValue.map((x) => x.toJson())),
//         "option_id": optionId,
//         "name": name,
//         "type": type,
//         "value": value,
//         "required": required,
//       };
// }
