import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/common/base_view_model/base_view_model.dart';
import 'package:todo_app/common/di/di.dart';
import 'package:todo_app/modules/task/data/model/task.dart';
import 'package:todo_app/modules/task/domain/usecases/add_task_usecase.dart';
import 'package:todo_app/modules/task/presentation/providers/task_providers.dart';

import 'add_task_form.dart';

class AddTaskViewmodel extends BaseViewModel {
  AddTaskViewmodel({AddTaskUseCase? addTaskUseCase}) : _useCase = addTaskUseCase ?? locator<AddTaskUseCase>();

  final AddTaskUseCase _useCase;

  final form = AddTaskForm();

  void addTask(WidgetRef ref, BuildContext context){
    final payload = Task(title: form.titleField.getValueAsString(), description: form.descriptionField.getValueAsString());
    _useCase.invoke(payload);
    ref.read(taskViewModelProvider.notifier).getTasks();
    context.pop();
  }

}