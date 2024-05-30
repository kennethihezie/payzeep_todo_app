import 'package:todo_app/common/di/di.dart';
import 'package:todo_app/modules/task/data/data_source/task_data_source.dart';
import 'package:todo_app/modules/task/data/model/task.dart';
import 'package:todo_app/modules/task/data/model/update_task.dart';

class TaskRepository {
  TaskRepository({TaskDataSource? taskDataSource}) : _dataSource = taskDataSource ?? locator<TaskDataSource>();

  final TaskDataSource _dataSource;

  List<Task> getTasks() => _dataSource.getTasks();

  void addTask(Task task) => _dataSource.addTask(task);

  void updateTask(UpdateTask updateTask) => _dataSource.updateTask(updateTask);
}