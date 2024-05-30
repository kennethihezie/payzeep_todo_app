import 'package:todo_app/common/base_view_model/base_view_model.dart';
import 'package:todo_app/common/di/di.dart';
import 'package:todo_app/modules/task/data/model/update_task.dart';
import 'package:todo_app/modules/task/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/modules/task/domain/usecases/update_task_usecase.dart';
import 'package:todo_app/modules/task/presentation/states/tasks_ui_state.dart';

class GetTasksViewmodel extends BaseViewModel {
  GetTasksViewmodel({GetTasksUseCase? getTasksUseCase, UpdateTasksUseCase? updateTasksUseCase}) : _getTasksUseCase = getTasksUseCase ?? locator<GetTasksUseCase>(), _updateTasksUseCase = updateTasksUseCase ?? locator<UpdateTasksUseCase>();

  final GetTasksUseCase _getTasksUseCase;
  final UpdateTasksUseCase _updateTasksUseCase;


  TasksUiState _uiState = TasksUiState();
  TasksUiState get uiState => _uiState;
  set uiState(TasksUiState value) {
    _uiState = value;
    notifyListeners();
  }

  void getTasks(){
    uiState = uiState.copyWith(tasks: _getTasksUseCase.invoke());
  }

  void updateTask(UpdateTask task) {
    _updateTasksUseCase.invoke(task);
    getTasks();
  }
}