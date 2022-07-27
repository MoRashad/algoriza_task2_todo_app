// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  TextWidget({
    required this.title,
    this.fontSize = 16,
    this.isTitle = true,
    Key? key,
  }) : super(key: key);
  String title;
  double fontSize;
  bool isTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
