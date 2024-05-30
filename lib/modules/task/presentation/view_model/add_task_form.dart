import 'package:todo_app/widgets/form/app_form.dart';
import 'package:todo_app/widgets/inputs/app_input_validator.dart';

class AddTaskForm extends AppForm {
  final titleField = TextAppFormField(validators: [const NonEmptyStringValidator(errorMessage: 'Title must not be empty')]);
  final descriptionField = TextAppFormField(validators: [const NonEmptyStringValidator(errorMessage: 'Description must not be empty')]);

  @override
  Set<AppFormField> fields() => { titleField, descriptionField };

  @override
  bool get isFormValid => titleField.isFieldValid && descriptionField.isFieldValid;
}