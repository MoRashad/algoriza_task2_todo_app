import 'package:flutter/material.dart';

import 'colors.dart';

final kInputDecoration = InputDecoration(
  fillColor: MyColors.textFieldColor,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: MyColors.textFieldColor,
    ),
    borderRadius: BorderRadius.circular(15),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: MyColors.textFieldColor,
    ),
    borderRadius: BorderRadius.circular(15),
  ),
);
