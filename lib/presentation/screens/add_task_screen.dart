import '../../constants/constant_values.dart';
import '../../cubit/task_cubit.dart';
import '../widgets/board_app_bar.dart';
import '../widgets/botton_widget.dart';
import '../widgets/text_widget.dart';
import '../../services/notification_services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import '../../constants/colors.dart';
import '../../constants/decoration.dart';
import '../widgets/date_widget.dart';
import '../widgets/drop_down_widget.dart';
import '../widgets/text_field_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    String valueChangedStart = '';
    String valueToValidateStart = '';
    String valueSavedStart = '';
    String valueChangedEnd = '';
    String valueToValidateEnd = '';
    String valueSavedEnd = '';
    TextEditingController titlecontroller = TextEditingController();
    String date = '';
    final List<String> items = [
      '1 day before',
      '1 hour before',
      '30 min before',
      '10 min before'
    ];
    String selectedReminder = '';
    String selectedColor = '';

    TextEditingController startTimeController = TextEditingController();
    TextEditingController endTimeController = TextEditingController();

    validateAndSave() async {
      if (titlecontroller.text.isNotEmpty &&
          date != '' &&
          startTimeController.text.isNotEmpty &&
          endTimeController.text.isNotEmpty &&
          selectedReminder != '' &&
          selectedColor != '') {
        TaskCubit.get(context).insetIntoTaskDatabase(
          title: titlecontroller.text,
          date: date,
          startTime: startTimeController.text,
          endTime: endTimeController.text,
          remind: selectedReminder,
          color: selectedColor,
        );

        notifyHelper.scheduledNotification(
          int.parse(startTimeController.text.split(":")[0]),
          int.parse(startTimeController.text.split(":")[1]),
          titlecontroller.text,
          date,
          startTimeController.text,
          selectedReminder,
        );

        // print(startTimeController.text);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('missing fields');
      }
      //notifyHelper.scheduledNotification();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: BoardAppBar(
          title: 'Add Task',
          isThereTabbar: false,
          trailingIcon: false,
        ),
      ),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(27.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(title: 'Title'),
                  const SizedBox(height: 5),
                  TextFieldWidget(titlecontroller: titlecontroller),
                  const SizedBox(height: 10),
                  TextWidget(title: 'Date'),
                  const SizedBox(height: 5),
                  DateTimePicker(
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Date',

                    onChanged: (val) => date = val,
                    //onSaved: (val) => date = val!.toString(),
                    decoration: kInputDecoration,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(title: 'Start time'),
                          const SizedBox(height: 5),
                          DateWidget(
                            TimeController: startTimeController,
                            valueChanged4: valueChangedStart,
                            valueSaved4: valueSavedStart,
                            valueToValidate4: valueToValidateStart,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(title: 'End time'),
                          const SizedBox(height: 5),
                          DateWidget(
                            TimeController: endTimeController,
                            valueChanged4: valueChangedEnd,
                            valueSaved4: valueSavedEnd,
                            valueToValidate4: valueToValidateEnd,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextWidget(title: 'Remind'),
                  const SizedBox(height: 5),
                  DropdownButtonFormField(
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
                      selectedReminder = value.toString();
                    },
                    //value: valueController,
                    borderRadius: BorderRadius.circular(25),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                  ),
                  // DropDownWidget(
                  //   items: items,
                  //   selecteditem: selectedReminder,
                  // ),
                  const SizedBox(height: 15),
                  TextWidget(title: 'Color'),
                  const SizedBox(height: 5),
                  DropdownButtonFormField(
                    decoration: kInputDecoration,
                    items: colors
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
                      selectedColor = value.toString();
                    },
                    //value: valueController,
                    borderRadius: BorderRadius.circular(25),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                  ),
                  // DropDownWidget(
                  //   selecteditem: selectedColor,
                  //   items: colors,
                  // ),
                  const SizedBox(height: 20),
                  BottonWidget(
                    buttonClicked: validateAndSave,
                    color: MyColors.bottonColor,
                    text: 'Create Task',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
