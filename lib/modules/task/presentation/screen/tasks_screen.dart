import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/common/extensions/extensions.dart';
import 'package:todo_app/common/navigation/pages.dart';
import 'package:todo_app/common/theme/color/app_colors.dart';
import 'package:todo_app/common/theme/typography/text_styles.dart';
import 'package:todo_app/modules/task/data/model/update_task.dart';
import 'package:todo_app/modules/task/presentation/providers/task_providers.dart';
import 'package:todo_app/modules/task/presentation/widget/task_card.dart';
import 'package:todo_app/widgets/app_bar/todo_appbar.dart';
import 'package:todo_app/widgets/inputs/app_radio_button.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(taskViewModelProvider);

    return Scaffold(
      appBar: TodoAppBar.primary(title: 'Tasks'),
      backgroundColor: AppColors.white,
      body: vm.uiState.tasks.isEmpty ? Center(child: Text('No Task. Click the + button to add task', style: AppTextStyle.body.medium)) : Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.builder(itemCount: vm.uiState.tasks.length, itemBuilder: (context, index) => TaskCard(task: vm.uiState.tasks[index], index: index)),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => context.push(AppPages.addTaskScreen), child: const Icon(Icons.add)),
    );
  }
}
