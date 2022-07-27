import 'package:flutter/material.dart';

class BottonWidget extends StatelessWidget {
  BottonWidget({
    Key? key,
    required this.buttonClicked,
    this.height = 50,
    required this.color,
    this.borderRaduis = 15,
    this.fontSize = 18,
    required this.text,
    this.textColor = Colors.white,
  }) : super(key: key);
  GestureTapCallback buttonClicked;
  double height;
  Color color;
  double borderRaduis;
  String text;
  double fontSize;
  Color textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonClicked,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRaduis),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
