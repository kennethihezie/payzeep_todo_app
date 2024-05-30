import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/common/extensions/extensions.dart';
import 'package:todo_app/common/theme/typography/text_styles.dart';
import 'package:todo_app/modules/task/data/model/task.dart';
import 'package:todo_app/modules/task/data/model/update_task.dart';
import 'package:todo_app/modules/task/presentation/providers/task_providers.dart';
import 'package:todo_app/widgets/inputs/app_radio_button.dart';

class TaskCard extends ConsumerWidget {
  const TaskCard({super.key, required this.task, required this.index});
  final Task task;
  final int index;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(taskViewModelProvider);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          AppRadioButton(onChange: (value) => vm.updateTask(UpdateTask(index: index, isDone: value ?? false))),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title, style: AppTextStyle.body.largeBold.copyWith(decoration: task.isDone ? TextDecoration.lineThrough : null)),

              4.verticalGap,

              Text(task.description, style: AppTextStyle.body.medium.copyWith(decoration: task.isDone ? TextDecoration.lineThrough : null)),
            ],
          )
        ],
      ),
    );
  }
}
