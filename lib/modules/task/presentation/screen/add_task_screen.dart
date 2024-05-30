import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/common/extensions/extensions.dart';
import 'package:todo_app/common/theme/color/app_colors.dart';
import 'package:todo_app/modules/task/presentation/providers/task_providers.dart';
import 'package:todo_app/widgets/app_bar/todo_appbar.dart';
import 'package:todo_app/widgets/buttons/app_buttons.dart';
import 'package:todo_app/widgets/cards/app_cards.dart';
import 'package:todo_app/widgets/inputs/app_input.dart';

class AddTaskScreen extends ConsumerWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(addTaskViewModelProvider);

    return Scaffold(
      appBar: TodoAppBar.primary(title: 'Add Task'),
      body: Container(
        color: AppColors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppCards.withTitle(
              title: 'Task Title',
              child: AppInput.text(
                  hintText: '',
                  formField: vm.form.titleField)
            ),

            16.verticalGap,

            AppCards.withTitle(
                title: 'Task Description',
                child: AppInput.text(
                    hintText: '',
                    formField: vm.form.descriptionField)
            ),


            const Spacer(),

            AppButton.primary(title: 'Create Task', onTap: () => vm.addTask(ref, context), state: vm.form.validState,)
          ],
        ),
      ),
    );
  }
}
