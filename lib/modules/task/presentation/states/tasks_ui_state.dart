import 'package:todo_app/modules/task/data/model/task.dart';

class TasksUiState {
  List<Task> tasks;

  TasksUiState({this.tasks = const []});

  TasksUiState copyWith({List<Task>? tasks}) => TasksUiState(tasks: tasks ?? this.tasks);
}