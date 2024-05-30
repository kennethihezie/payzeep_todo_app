import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/widgets/inputs/app_input_validator.dart';
import 'package:todo_app/widgets/inputs/input_validation_state.dart';


abstract class AppForm {
  static const specialCharacterText = 'special character';
  static const upperCaseText = 'upper-case character';
  static const lowerCaseText = 'lower-case character';
  static const numberText = 'number';
  static const passwordLengthText = 'at least 8 characters';

  final ValueNotifier<bool> _validated = ValueNotifier<bool>(false);
  final bool autoValidate;

  AppForm({this.autoValidate = false}) {
    bool shouldNotify = true;

    fields().forEach((element) {
      element.addListener(() async {
        // There's no point triggering isValid since it will be
        // triggered When focus is lost on the field
        if (shouldNotify) {
          shouldNotify = false;
          if (!element.validateOnFocusLost) element.isValid();
          _validated.value = isFormValid;
          final a = _validated.value;
          Future.delayed(const Duration(milliseconds: 80), () {
            shouldNotify = true;
          });
        }
      });
    });
  }

  ValueNotifier<bool> get validState => _validated;

  bool get isFormValid;

  Set<AppFormField> fields() => {};

  void reset() {
    fields().forEach((element) {
      element.value = null;
      element.clearValidationError();
    });
  }

  clearAllValidationError() {
    fields().forEach((element) {
      element.clearValidationError();
    });
  }

  updateValidState() {
    _validated.value = isFormValid;
  }

  @mustCallSuper
  void dispose() {
    fields().forEach((element) {
      element.dispose();
    });
    _validated.dispose();
  }
}

abstract class AppFormField<T> extends ChangeNotifier {
  AppFormField({
    this.validators = const [],
    this.validateOnFocusLost = true
  });

  final List<AppInputValidator<T>> validators;
  final bool validateOnFocusLost;

  String? _validationError;

  String? get validationError => _validationError;

  ///Same as isValid(notifyError=false)
  bool get isFieldValid => isValid(notifyError: false);

  set validationError(String? newValue) {
    _validationError = newValue;
    notifyListeners();
  }

  T? _value;

  T? get value => _value;

  set value(T? newValue) {
    _value = newValue;
    notifyListeners();
  }

  bool isValid({bool notifyError = true}) {
    for (final validator in validators) {
      if (!validator.isValid(value)) {
        if (notifyError) {
          setValidationError(errorMessage: validator.errorMessage);
        }
        return false;
      }
    }
    if (notifyError == true) setValidationError();
    return true;
  }

  void setValidationError({String? errorMessage}) {
    validationError = errorMessage;
  }

  void clearValidationError() {
    validationError = null;
  }

  void clear() {
    value = null;
    clearValidationError();
  }

  void setValueFromString(String data) {}

  void setValueFromType(T data) {}

  String getValueAsString();
}

class TextAppFormField extends AppFormField<String> {
  TextAppFormField({super.validators, super.validateOnFocusLost});

  @override
  String getValueAsString() {
    return value ?? '';
  }

  @override
  void setValueFromString(String data) {
    value = data;
  }
}


class AppFormFieldAdapter<T extends AppFormField> implements ValueListenable<T> {
  final T notifier;

  AppFormFieldAdapter(this.notifier);

  @override
  T get value => notifier;

  @override
  void addListener(VoidCallback listener) {
    notifier.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    notifier.removeListener(listener);
  }
}
