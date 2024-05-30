import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/common/navigation/app_router.dart';
import 'package:todo_app/common/services/navigation_service.dart';
import 'package:todo_app/modules/task/data/data_source/task_data_source.dart';
import 'package:todo_app/modules/task/data/repository/task_repository.dart';
import 'package:todo_app/modules/task/domain/usecases/add_task_usecase.dart';
import 'package:todo_app/modules/task/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/modules/task/domain/usecases/update_task_usecase.dart';



GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {

  locator.registerLazySingleton<NavigationService>(() => NavigationService());

  locator.registerSingleton<GoRouter>(router());

  locator.registerSingleton<TaskDataSource>(TaskDataSource());

  locator.registerSingleton<TaskRepository>(TaskRepository());

  locator.registerSingleton<GetTasksUseCase>(GetTasksUseCase());

  locator.registerSingleton<UpdateTasksUseCase>(UpdateTasksUseCase());

  locator.registerSingleton<AddTaskUseCase>(AddTaskUseCase());
}
