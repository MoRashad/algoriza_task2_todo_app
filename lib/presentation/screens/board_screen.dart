// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:algoriza_task2_todo_app/constants/colors.dart';
import 'package:algoriza_task2_todo_app/constants/constant_values.dart';
import 'package:algoriza_task2_todo_app/cubit/task_cubit.dart';
import 'package:algoriza_task2_todo_app/presentation/widgets/all_list_tab.dart';
import 'package:algoriza_task2_todo_app/presentation/widgets/board_app_bar.dart';
import 'package:algoriza_task2_todo_app/presentation/widgets/botton_widget.dart';
import 'package:algoriza_task2_todo_app/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  var tasks, newTasks, completedTasks, favouritedTasks;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotificationServices();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if ((state) is AppGetDatabaseState) {
          tasks = BlocProvider.of<TaskCubit>(context).allTasks;

          newTasks = BlocProvider.of<TaskCubit>(context).newTasks;
          completedTasks = BlocProvider.of<TaskCubit>(context).completedTasks;
          favouritedTasks = BlocProvider.of<TaskCubit>(context).favouritedTasks;
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(110),
              child: BoardAppBar(
                title: 'Board',
                tasks: tasks,
              ),
            ),
            body: state is AppGetDatabaseState
                ? TabBarView(
                    children: <Widget>[
                      AllListTab(
                        tasks: tasks,
                      ),
                      AllListTab(
                        tasks: completedTasks,
                      ),
                      AllListTab(tasks: newTasks),
                      AllListTab(tasks: favouritedTasks),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
            bottomSheet: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: BottonWidget(
                  buttonClicked: () {
                    //notifyHelper.scheduledNotification();
                    Navigator.pushNamed(context, '/add_task_screen');
                  },
                  color: MyColors.bottonColor,
                  text: 'Add Task',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
