import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoeyapp/model/tasks_data.dart';
import 'package:provider/provider.dart';


class AddTaskScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String taskTitle;
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Add Task",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.purpleAccent,
              fontSize: 30.0,
              fontWeight: FontWeight.w700
            ),),
            TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (newValue){
                  taskTitle=newValue;
                },
            ),
            SizedBox(height: 10.0,),
            FlatButton(
              onPressed: (){
               Provider.of<TaskData>(context,listen: false).addNewTask(taskTitle);
               Navigator.pop(context);
              },
              child: Text("Add",style: TextStyle(color: Colors.white),),
              color: Colors.purpleAccent,
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20.0),topLeft: Radius.circular(20.0))
        ),

      ),
    );
  }
}
