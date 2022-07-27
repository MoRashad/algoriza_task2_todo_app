import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../../constants/decoration.dart';

class DateWidget extends StatefulWidget {
  DateWidget({
    required this.valueChanged4,
    required this.valueSaved4,
    required this.valueToValidate4,
    required this.TimeController,
    Key? key,
  }) : super(key: key);
  String valueChanged4;
  String valueToValidate4;
  String valueSaved4;
  TextEditingController TimeController;

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: DateTimePicker(
        decoration: kInputDecoration,
        type: DateTimePickerType.time,
        timePickerEntryModeInput: true,
        controller: widget.TimeController,
        //initialValue: ' ', //_initialValue,
        icon: const Icon(Icons.timer_outlined),
        timeLabelText: "Time",
        use24HourFormat: false,
        locale: const Locale('EN', 'UK'),
        onChanged: (val) {
          setState(() {
            widget.valueChanged4 = val;
            print(widget.valueChanged4);
          });
        },

        validator: (val) {
          setState(() => widget.valueToValidate4 = val ?? '');
          return null;
        },
        onSaved: (val) => setState(() => widget.valueSaved4 = val ?? ''),
      ),
    );
  }
}
