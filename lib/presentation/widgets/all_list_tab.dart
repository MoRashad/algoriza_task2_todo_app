import '../../constants/colors.dart';
import '../../constants/constant_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/task_cubit.dart';

class AllListTab extends StatefulWidget {
  AllListTab({Key? key, required this.tasks}) : super(key: key);
  var tasks;
  @override
  State<AllListTab> createState() => _AllListTabState();
}

class _AllListTabState extends State<AllListTab> {
  List<bool> isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  var menuItems = ['Favourite', 'Complete', 'Remove'];

  onSelect(String item, int index) {
    switch (item) {
      case 'Favourite':
        TaskCubit.get(context)
            .updateFavouriteDatabase('true', widget.tasks[index]['id']);
        setState(() {
          menuItems[0] = 'Unfavourite';
        });
        print('Favourite clicked');
        break;
      case 'Complete':
        TaskCubit.get(context)
            .updateCompleteDatabase('Completed', widget.tasks[index]['id']);
        setState(() {
          menuItems[1] = 'Uncomplete';
        });
        print('Complete clicked');
        break;
      case 'Remove':
        print('Remove clicked');
        TaskCubit.get(context).deleteFromDatabase(widget.tasks[index]['id']);
        break;
      case 'Unfavourite':
        TaskCubit.get(context)
            .updateFavouriteDatabase('false', widget.tasks[index]['id']);
        setState(() {
          menuItems[0] = 'Favourite';
        });
        break;
      case 'Uncomplete':
        TaskCubit.get(context)
            .updateCompleteDatabase('new', widget.tasks[index]['id']);
        setState(() {
          menuItems[1] = 'Complete';
        });
    }
  }

  isComplete(int index) {
    if (widget.tasks[index]['status'] == 'Completed') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<TaskCubit>(context).loadDatabase();
        },
        child: ListView.builder(
          itemCount: widget.tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: CheckboxListTile(
                activeColor: taskColor(widget.tasks, index),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                side: BorderSide(
                  color: taskColor(widget.tasks, index),
                  width: 2,
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: isComplete(index),
                onChanged: (bool? value) {
                  setState(() {
                    isSelected[index] = value!;
                  });
                },
                title: Text(
                  widget.tasks[index]['title'],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                secondary: PopupMenuButton<String>(
                  onSelected: (String item) {
                    onSelect(item, index);
                  },
                  itemBuilder: (BuildContext context) {
                    return menuItems.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
