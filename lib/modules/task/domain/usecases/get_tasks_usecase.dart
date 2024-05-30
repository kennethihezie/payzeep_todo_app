import 'package:todo_app/common/di/di.dart';
import 'package:todo_app/common/usecase/usecase.dart';
import 'package:todo_app/modules/task/data/model/task.dart';
import 'package:todo_app/modules/task/data/repository/task_repository.dart';

class GetTasksUseCase extends UseCase<void, List<Task>> {
  GetTasksUseCase({ TaskRepository? taskRepository}) : _repository = taskRepository ?? locator<TaskRepository>();
  final TaskRepository _repository;

  @override
  List<Task> invoke([void input]) {
    return _repository.getTasks();
  }
}