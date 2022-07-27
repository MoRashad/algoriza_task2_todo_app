// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

const snackBar = SnackBar(
  content: Text('Cannot procceed, please enter missing fields'),
);
final List<String> colors = ['Blue', 'Red', 'Orange', 'Yellow'];

taskColor(var tasks, int index) {
  if (tasks[index]['color'] == 'Red') {
    return Colors.red;
  } else if (tasks[index]['color'] == 'Blue') {
    return Colors.blue;
  } else if (tasks[index]['color'] == 'Yellow') {
    return Colors.yellow;
  } else if (tasks[index]['color'] == 'Orange') {
    return Colors.orange;
  } else {
    return Colors.black;
  }
}

var notifyHelper;
