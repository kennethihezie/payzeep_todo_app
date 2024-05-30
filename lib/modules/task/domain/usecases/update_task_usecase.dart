import 'package:todo_app/common/di/di.dart';
import 'package:todo_app/common/usecase/usecase.dart';
import 'package:todo_app/modules/task/data/model/update_task.dart';
import 'package:todo_app/modules/task/data/repository/task_repository.dart';

class UpdateTasksUseCase extends UseCase<UpdateTask, void> {
  UpdateTasksUseCase({ TaskRepository? taskRepository}) : _repository = taskRepository ?? locator<TaskRepository>();
  final TaskRepository _repository;

  @override
  void invoke(input) {
    return _repository.updateTask(input);
  }
}