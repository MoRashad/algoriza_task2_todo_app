// ignore_for_file: must_be_immutable

import 'package:algoriza_task2_todo_app/constants/colors.dart';
import 'package:algoriza_task2_todo_app/constants/constant_values.dart';
import 'package:algoriza_task2_todo_app/cubit/task_cubit.dart';
import 'package:algoriza_task2_todo_app/presentation/widgets/board_app_bar.dart';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({required this.tasks, Key? key}) : super(key: key);
  var tasks;
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _selectedDate = DateTime.now();
  DatePickerController datecontroller = DatePickerController();
  var allTasks;
  @override
  @override
  Widget build(BuildContext context) {
    allTasks = TaskCubit().allTasks;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoardAppBar(
                title: 'Schedule',
                isThereTabbar: false,
                trailingIcon: false,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  dayTextStyle: const TextStyle(
                    fontSize: 12,
                  ),
                  dateTextStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  selectionColor: MyColors.bottonColor,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  controller: datecontroller,
                  height: 80,
                  width: 50,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Text(
                  _selectedDate.toString().substring(0, 10).trim(),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: BlocProvider(
          create: (context) => TaskCubit(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(height: 15);
              },
              itemCount: widget.tasks.length, //widget.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.tasks[index]['date'] ==
                        _selectedDate
                            .toString()
                            .substring(0, 10)
                            .trim() //Completed'
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: taskColor(widget.tasks, index),
                        ),
                        height: 90,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.tasks[index]['startTime'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.tasks[index]['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                widget.tasks[index]['status'] == "new"
                                    ? Icons.assignment_turned_in_outlined
                                    : Icons.assignment_turned_in_rounded,
                                color: Colors.grey[100],
                              )
                            ],
                          ),
                        ),
                      )
                    : Container();
              },
            ),
          ),
        ));
  }
}
