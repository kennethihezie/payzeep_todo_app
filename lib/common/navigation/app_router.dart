import 'package:go_router/go_router.dart';
import 'package:todo_app/common/di/di.dart';
import 'package:todo_app/common/navigation/pages.dart';
import 'package:todo_app/common/services/navigation_service.dart';
import 'package:todo_app/modules/task/presentation/screen/add_task_screen.dart';
import 'package:todo_app/modules/task/presentation/screen/tasks_screen.dart';



GoRouter router() => GoRouter(
  navigatorKey: locator<NavigationService>().navigatorKey,
  routes: [
    GoRoute(
        name: AppPages.addTaskScreen,
        path: AppPages.addTaskScreen,
        builder: (_, state) => const AddTaskScreen()),


    GoRoute(
        name: AppPages.taskScreen,
        path: AppPages.taskScreen,
        builder: (_, state) => const TasksScreen()),
  ]
);