import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'task.dart';

class TaskData extends ChangeNotifier{
  List<Task> _tasks=[
    Task(name: "Buy a"),
    Task(name: "Buy B"),
    Task(name: "Buy C"),
  ];

  int get taskCount {
    return _tasks.length;
  }

  UnmodifiableListView<Task> get tasks{
    return UnmodifiableListView(_tasks);
  }

  void addNewTask(String newTaskTitle){
    _tasks.add(Task(name: newTaskTitle));
    notifyListeners();
  }

  void updateTask(Task task){
    task.toggleDone();
    notifyListeners();
  }
  
  void deleteTask(Task task){
    _tasks.remove(task);
    notifyListeners();
  }
}