import 'package:todo_app/common/di/di.dart';
import 'package:todo_app/common/usecase/usecase.dart';
import 'package:todo_app/modules/task/data/model/task.dart';
import 'package:todo_app/modules/task/data/repository/task_repository.dart';

class AddTaskUseCase extends UseCase<Task, void> {
  AddTaskUseCase({ TaskRepository? taskRepository}) : _repository = taskRepository ?? locator<TaskRepository>();
  final TaskRepository _repository;

  @override
  void invoke(Task input) {
    return _repository.addTask(input);
  }
}