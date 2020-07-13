import 'package:flutter/material.dart';
import 'package:todoeyapp/model/tasks_data.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {  
    return Consumer<TaskData>(
      builder: (context, taskData, child){
        return ListView.builder(
            itemCount: taskData.taskCount,
            itemBuilder: (context,index){
              return TaskTile(
                  title: Provider.of<TaskData>(context).tasks[index].name ,  // instead of
                  isChecked: Provider.of<TaskData>(context).tasks[index].isDone,
                  checkboxCallback: (bool checkboxState){
                    taskData.updateTask(taskData.tasks[index]);
                  },
                  longPressCallback: (){
                    taskData.deleteTask(taskData.tasks[index]);
              }
              );
            });
      },
    );
  }
}
