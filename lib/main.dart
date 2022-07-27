import 'constants/constant_values.dart';
import 'cubit/task_cubit.dart';
import 'presentation/screens/add_task_screen.dart';
import 'presentation/screens/board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return MaterialApp(
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.black),
        fontFamily: GoogleFonts.kanit().fontFamily,
        backgroundColor: Colors.white,
      ),
      //home: const BoardScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
              create: (context) => TaskCubit()..initDatabase(),
              child: const BoardScreen(),
            ),
        '/add_task_screen': (context) => BlocProvider(
              create: (context) => TaskCubit()..initDatabase(),
              child: const AddTaskScreen(),
            ),
        // '/calendar_screen': (context) => BlocProvider(
        //       create: (context) => TaskCubit()..initDatabase(),
        //       child: const CalendarScreen(),
        //     ),
      },
    );
  }
}
