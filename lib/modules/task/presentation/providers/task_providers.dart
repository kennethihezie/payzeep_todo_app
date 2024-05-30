import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/modules/task/presentation/view_model/add_task_viewmodel.dart';
import 'package:todo_app/modules/task/presentation/view_model/tasks_viewmodel.dart';

final taskViewModelProvider = ChangeNotifierProvider((_) => GetTasksViewmodel());
final addTaskViewModelProvider = ChangeNotifierProvider((_) => AddTaskViewmodel());