import 'package:flutter/material.dart';
import 'package:kharoof_reefy/consts/sizes.dart';
import 'package:kharoof_reefy/models/option_value_model.dart';
import 'package:kharoof_reefy/models/options_model.dart';

class BuildSelect extends StatefulWidget {
  final OptionModel option;
  BuildSelect({Key key, @required this.option}) : super(key: key);

  @override
  _BuildSelectState createState() => _BuildSelectState();
}

class _BuildSelectState extends State<BuildSelect> {
  List<OptionValueModel> optionValues = [];
  int selectedOption = 0;

  void fetchOption() {
    optionValues.clear();
    for (var item in widget.option.optionValue) {
      optionValues.add(item);
    }
  }

  @override
  void initState() {
    fetchOption();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                    content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${widget.option.name}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.grey,
                    )
                  ]
                    ..addAll(optionValues.map((e) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value:
                                    selectedOption == optionValues.indexOf(e),
                                onChanged: (bool value) {
                                  selectedOption = optionValues.indexOf(e);
                                  Navigator.of(context).pop();
                                  setState(() {});
                                },
                                checkColor: Colors.white,
                                activeColor: Color(0xffe5a65f),
                                // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              Expanded(
                                  child: Text(
                                '${e.name}',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              )),
                            ]),
                      );
                    }).toList())
                    ..addAll([
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: deviceWidth * 0.25,
                              height: deviceHeight * 0.05,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  )),
                              child: Center(child: Text('إغلاق')),
                            ),
                          ),
                          Container(
                            width: deviceWidth * 0.25,
                            height: deviceHeight * 0.05,
                            decoration: BoxDecoration(
                                color: Color(0xffe5a65f),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                )),
                            child: Center(
                                child: Text(
                              'حفظ',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      )
                    ]),
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white),
          height: 70,
          width: deviceWidth * 0.9,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${optionValues[selectedOption].name}',
                    style: TextStyle(color: Color(0xffb09577), fontSize: 13),
                  ),
                  Spacer(),
                  Text(
                    '${widget.option.name}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
