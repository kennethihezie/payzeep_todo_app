import 'package:todo_app/modules/task/data/model/task.dart';
import 'package:todo_app/modules/task/data/model/update_task.dart';

class TaskDataSource {
   final List<Task> _tasks = [];

   List<Task> getTasks() => _tasks;

   addTask(Task task) => _tasks.add(task);

   updateTask(UpdateTask updateTask) => _tasks[updateTask.index].isDone = updateTask.isDone;
}