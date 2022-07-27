import '../screens/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoardAppBar extends StatelessWidget {
  BoardAppBar({
    required this.title,
    this.isThereTabbar = true,
    this.trailingIcon = true,
    this.tasks = '',
    Key? key,
  }) : super(key: key);
  var tasks;
  String title;
  bool isThereTabbar;
  bool trailingIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: title != 'Board'
          ? Padding(
              padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  FontAwesomeIcons.angleLeft,
                  color: Colors.black,
                ),
              ),
            )
          : null,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        trailingIcon
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 15, 0),
                child: IconButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/calendar_screen');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalendarScreen(
                                  tasks: tasks,
                                )));
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.black,
                  ),
                ),
              )
            : Container(),
      ],
      bottom: isThereTabbar
          ? const TabBar(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2,
              //controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(
                    'Uncompleted',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(
                    'Favourites',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
