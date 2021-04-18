import 'package:flutter/material.dart';

class CustomRadioWidget<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final double width;
  final double height;

  CustomRadioWidget(
      {this.value,
      this.groupValue,
      this.onChanged,
      this.width = 32,
      this.height = 32});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onChanged(this.value);
        },
        child: Container(
          height: this.height,
          width: this.width,
          decoration: ShapeDecoration(
            shape: CircleBorder(),
            color: Color(0xffe5a65f),
          ),
          child: Center(
            child: Container(
              height: this.height - 3,
              width: this.width - 3,
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: Color(0xffe9f7fb),
              ),
              child: Center(
                child: Container(
                  height: this.height - 12,
                  width: this.width - 12,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: value == groupValue
                        ? Color(0xffe5a65f)
                        : Color(0xffe9f7fb),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
