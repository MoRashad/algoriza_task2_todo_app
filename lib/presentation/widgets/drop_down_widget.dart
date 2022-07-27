import 'package:flutter/material.dart';

import '../../constants/colors.dart';

import '../../constants/decoration.dart';

class DropDownWidget extends StatelessWidget {
  DropDownWidget({
    Key? key,
    required this.items,
    required this.selecteditem,
  }) : super(key: key);

  final List<dynamic> items;
  String selecteditem;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: kInputDecoration,
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ))
          .toList(),
      onChanged: (value) {
        selecteditem = value.toString();
      },
      //value: valueController,
      borderRadius: BorderRadius.circular(25),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
    );
  }
}
