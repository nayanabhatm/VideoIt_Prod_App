import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool isChecked;
  final Function checkboxCallback;
  final Function longPressCallback;

  TaskTile({this.title,this.isChecked,this.checkboxCallback,this.longPressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      title: Text(title,
      style: TextStyle(
        decoration: isChecked?TextDecoration.lineThrough:null,
        ),
      ),
      trailing: Checkbox(
          activeColor: Colors.purpleAccent,
          value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}