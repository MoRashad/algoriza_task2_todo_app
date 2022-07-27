// ignore_for_file: prefer_const_constructors

import 'package:algoriza_task2_todo_app/cubit/task_cubit.dart';
import 'package:algoriza_task2_todo_app/presentation/screens/board_screen.dart';
import 'package:algoriza_task2_todo_app/presentation/screens/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    _configureLocalTimeZone();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title!),
    //     content: Text(body!),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => BoardScreen(),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
    SnackBar(content: const Text('welcome'));
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    BlocProvider(create: (context) => TaskCubit(), child: BoardScreen());
  }

  scheduledNotification(int hour, int minute, String title, String date,
      String startTime, String remind) async {
    int year = int.parse(date.split('-')[0]);
    int month = int.parse(date.split('-')[1]);
    int day = int.parse(date.split('-')[2]);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      'reminder for your schedule at $startTime',
      _convertTime(hour, minute, remind, year, month, day),
      //tz.TZDateTime.now(tz.local).add(Duration(seconds: minute)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  tz.TZDateTime _convertTime(
      int hour, int minute, String remind, int year, int month, int day) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate;
    if (remind == '10 min before') {
      scheduleDate =
          tz.TZDateTime(tz.local, year, month, day, hour, minute - 10);
    } else if (remind == '30 min before') {
      scheduleDate =
          tz.TZDateTime(tz.local, year, month, day, hour, minute - 30);
    } else if (remind == '1 hour before') {
      scheduleDate =
          tz.TZDateTime(tz.local, year, month, day, hour - 1, minute);
    } else {
      scheduleDate =
          tz.TZDateTime(tz.local, year, month, day - 1, hour, minute);
    }

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }
}
