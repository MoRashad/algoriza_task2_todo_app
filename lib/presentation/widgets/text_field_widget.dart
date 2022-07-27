import '../../constants/colors.dart';
import 'package:flutter/material.dart';

import '../../constants/decoration.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.titlecontroller,
  }) : super(key: key);

  final TextEditingController titlecontroller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titlecontroller,
      cursorColor: Colors.black,
      decoration: kInputDecoration,
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this feild cannot be empty';
        }
        return null;
      },
    );
  }
}
