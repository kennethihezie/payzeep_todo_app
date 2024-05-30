import 'package:flutter/material.dart';

import 'input_validation_state.dart';

abstract class AppInputValidator<T> {
  const AppInputValidator(
      {required this.hint,
      required this.shortHint,
      required this.errorMessage,
      this.validateOnField});

  final String hint;
  final String shortHint;
  final String errorMessage;
  final dynamic Function(T? value)? validateOnField;

  bool isValid(T? input);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppInputValidator &&
        runtimeType == other.runtimeType &&
        hint == other.hint &&
        shortHint == other.shortHint &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      hint.hashCode ^
      shortHint.hashCode ^
      errorMessage.hashCode;
}

class LowercaseValidator<T> extends AppInputValidator<T> {
  const LowercaseValidator({
    String? hint,
    String? shortHint,
    String? errorMessage,
  }) : super(
          hint: hint ?? 'Must contain a lowercase letter',
          shortHint: shortHint ?? 'A lowercase letter (a)',
          errorMessage:
              errorMessage ?? 'Must contain at least one lowercase letter',
        );

  @override
  bool isValid(T? input) {
    final inputToValidate = validateOnField?.call(input) ?? input;
    return inputToValidate?.toString().contains(RegExp('.*[a-z].*')) ?? false;
  }

  @override
  bool operator ==(Object other) => other is LowercaseValidator;

  @override
  int get hashCode => super.hashCode ^ runtimeType.hashCode;
}

class UppercaseValidator<T> extends AppInputValidator<T> {
  const UppercaseValidator({
    super.validateOnField,
    String? hint,
    String? shortHint,
    String? errorMessage,
  }) : super(
          hint: hint ?? 'Must contain an uppercase letter',
          shortHint: shortHint ?? 'A uppercase letter (A)',
          errorMessage:
              errorMessage ?? 'Must contain at least one uppercase letter',
        );

  @override
  bool isValid(T? input) {
    final inputToValidate = validateOnField?.call(input) ?? input;
    return inputToValidate?.toString().contains(RegExp('.*[A-Z].*')) ?? false;
  }

  @override
  bool operator ==(Object other) => other is UppercaseValidator;

  @override
  int get hashCode => super.hashCode ^ runtimeType.hashCode;
}

class NumberValidator<T> extends AppInputValidator<T> {
  const NumberValidator({
    super.validateOnField,
    String? hint,
    String? shortHint,
    String? errorMessage,
  }) : super(
          hint: hint ?? 'Must contain a number',
          shortHint: shortHint ?? 'A number (1)',
          errorMessage: errorMessage ?? 'Must contain at least one number',
        );

  @override
  bool isValid(T? input) {
    final inputToValidate = validateOnField?.call(input) ?? input;
    return inputToValidate?.toString().contains(RegExp('.*[0-9].*')) ?? false;
  }

  @override
  bool operator ==(Object other) => other is NumberValidator;

  @override
  int get hashCode => super.hashCode ^ runtimeType.hashCode;
}

class SpecialCharValidator extends AppInputValidator<String> {
  const SpecialCharValidator({
    String? hint,
    String? shortHint,
    String? errorMessage,
  }) : super(
          hint: hint ?? 'Must contain a special character',
          shortHint: shortHint ?? 'A special character (!@#)',
          errorMessage:
              errorMessage ?? 'Must contain at least one special character',
        );

  @override
  bool isValid(String? input) {
    return input == null ? false : input.contains(RegExp(r'.*[^\w\s].*'));
  }

  @override
  bool operator ==(Object other) => other is SpecialCharValidator;

  @override
  int get hashCode => super.hashCode ^ runtimeType.hashCode;
}

class MinLengthValidator<T> extends AppInputValidator<T> {
  const MinLengthValidator(
    this.minLength, {
    super.validateOnField,
    String? hint,
    String? shortHint,
    String? errorMessage,
  }) : super(
          hint: hint ?? 'Must be at least $minLength characters',
          shortHint: shortHint ?? '$minLength characters minimum',
          errorMessage:
              errorMessage ?? 'Must be at least $minLength characters',
        );
  final int minLength;

  @override
  bool isValid(T? input) {
    final inputToValidate = validateOnField?.call(input) ?? input;
    return inputToValidate == null
        ? false
        : (inputToValidate?.toString().length ?? 0) >= minLength;
  }

  @override
  bool operator ==(Object other) =>
      other is MinLengthValidator && minLength == other.minLength;

  @override
  int get hashCode => super.hashCode ^ minLength.hashCode;
}

class NonEmptyStringValidator<T> extends AppInputValidator<T> {
  const NonEmptyStringValidator(
      {super.hint = 'Enter a non-empty string',
      super.shortHint = 'Non-empty string',
      super.errorMessage = 'Input must not be empty',
      super.validateOnField});

  @override
  bool isValid(T? input) {
    final inputToValidate = validateOnField?.call(input) ?? input;
    return inputToValidate != null &&
        inputToValidate?.toString().trim().isNotEmpty == true;
  }

  @override
  bool operator ==(Object other) => other is NonEmptyStringValidator;

  @override
  int get hashCode => super.hashCode ^ runtimeType.hashCode;
}

class EmailAddressValidator extends AppInputValidator<String> {
  const EmailAddressValidator({
    String? hint,
    String? shortHint,
    String? errorMessage,
  }) : super(
          hint: hint ?? 'Enter your email address',
          shortHint: shortHint ?? 'Email Address',
          errorMessage: errorMessage ?? 'Invalid email address',
        );

  @override
  bool isValid(String? input) {
    // Use a regular expression to validate the email address
    final emailRegex = RegExp(r"^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$");
    return emailRegex.hasMatch(input ?? '');
  }

  @override
  bool operator ==(Object other) => other is EmailAddressValidator;

  @override
  int get hashCode => super.hashCode ^ runtimeType.hashCode;
}

class NigerianPhoneNumberValidator extends AppInputValidator<String> {
  const NigerianPhoneNumberValidator({
    String? hint,
    String? shortHint,
    String? errorMessage,
  }) : super(
          hint: hint ?? 'Enter your phone number',
          shortHint: shortHint ?? 'Phone Number',
          errorMessage: errorMessage ?? 'Invalid phone number',
        );

  @override
  bool isValid(String? input) {
    final value = input?.replaceAll(' ', '') ?? '';
    // Use a regular expression to validate the Nigerian phone number
    final nigerianPhoneNumberRegex = RegExp(
      r'^(?:(?:\+|0{0,2})234[\s-]?(?!0)(?:[1-9]{1}\d{2}[\s-]?\d{3}[\s-]?\d{4}|[1-9]{1}[0-9]{9})|0?(?!0)(?:[1-9]{1}\d{2}[\s-]?\d{3}[\s-]?\d{4}|[1-9]{1}[0-9]{9})|\+?(?!0)(?:[1-9]{1}\d{2}[\s-]?\d{3}[\s-]?\d{4}|[1-9]{1}[0-9]{9}))$',
    );
    return nigerianPhoneNumberRegex.hasMatch(value);
  }

  @override
  bool operator ==(Object other) => other is NigerianPhoneNumberValidator;

  @override
  int get hashCode => super.hashCode ^ runtimeType.hashCode;
}

class SameValueValidator<T> extends AppInputValidator<T> {
  SameValueValidator(
      {String? hint,
       String? shortHint,
      String? errorMessage,
      required this.comparator})
      : super(
            hint: hint ?? '',
            shortHint: shortHint ?? '',
            errorMessage: errorMessage ?? '');

  final bool Function(T? input) comparator;

  @override
  bool isValid(T? input) {
    return comparator.call(input);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SameValueValidator &&
        super == other &&
        comparator == other.comparator;
  }

  @override
  int get hashCode => super.hashCode ^ comparator.hashCode;
}

class PinLengthValidator extends AppInputValidator<String> {
  const PinLengthValidator({
    super.hint = 'Enter your PIN',
    super.shortHint = 'PIN',
    super.errorMessage = 'Invalid PIN length',
    this.pinLength = 4,
  });

  final int pinLength;

  @override
  bool isValid(String? input) {
    if (input == null) {
      return false;
    }
    final length = input.trim().length;
    return length == pinLength && int.tryParse(input) != null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PinLengthValidator &&
        super == other &&
        pinLength == other.pinLength;
  }

  @override
  int get hashCode => super.hashCode ^ pinLength.hashCode;
}

class AmountValidator extends AppInputValidator<double> {
  const AmountValidator(
      {super.hint = 'Enter a valid amount',
      super.shortHint = 'Amount',
      super.errorMessage = 'Invalid amount',
      this.minAmount = 0.0,
      this.maxAmount = double.maxFinite});

  final double minAmount;
  final double maxAmount;

  @override
  bool isValid(double? input) {
    if (input == null) {
      return false;
    }
    return (input >= minAmount && input <= maxAmount);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AmountValidator &&
        super == other &&
        minAmount == other.minAmount &&
        maxAmount == other.maxAmount;
  }

  @override
  int get hashCode => super.hashCode ^ minAmount.hashCode ^ maxAmount.hashCode;
}

// Exact length validator
class ExactLengthValidator extends AppInputValidator<String> {
  final int length;

  const ExactLengthValidator({
    String? hint,
    String? shortHint,
    String? errorMessage,
    this.length = 10,
  }) : super(
          hint: hint ?? 'Please enter your input',
          shortHint: shortHint ?? 'Input',
          errorMessage:
              errorMessage ?? 'Input must be exactly $length characters',
        );

  @override
  bool isValid(String? input) {
    if (input == null) {
      return false;
    }
    return input.length == length;
  }

  @override
  bool operator ==(Object other) {
    if (super == other) return true;
    return other is ExactLengthValidator &&
        runtimeType == other.runtimeType &&
        length == other.length &&
        super == other;
  }

  @override
  int get hashCode => super.hashCode ^ length.hashCode;
}

// DateValidator for invalidate date input
class DateValidator extends AppInputValidator<String> {
  const DateValidator({
    String? hint,
    String? shortHint,
    String? errorMessage,
  }) : super(
          hint: hint ?? 'Please enter your input',
          shortHint: shortHint ?? 'Input',
          errorMessage: errorMessage ?? 'Invalid date',
        );

  @override
  bool isValid(String? input) {
    return DateTime.tryParse(input ?? '') != null;
  }

  @override
  bool operator ==(Object other) {
    if (super == other) return true;
    return other is DateValidator &&
        runtimeType == other.runtimeType &&
        super == other;
  }

  @override
  int get hashCode => super.hashCode ^ runtimeType.hashCode;
}

class RegexpValidator<T> extends AppInputValidator<T> {
  RegexpValidator({
    required String regexp,
    String? hint,
    String? shortHint,
    String? errorMessage,
    super.validateOnField
  }) :
        regexp = RegExp(regexp),
        super(
    hint: hint ?? 'Please enter your input',
    shortHint: shortHint ?? 'Input',
    errorMessage: errorMessage ?? 'Invalid input'
  );

  final RegExp regexp;

  @override
  bool isValid(T? input) {
    final inputToValidate = validateOnField?.call(input) ?? input;
    return inputToValidate == null ? false : regexp.hasMatch(inputToValidate?.toString() ?? '');
  }
}

class RemoteValidationValidator<T> extends AppInputValidator<InputValidationState<T>> {
  RemoteValidationValidator({
    String? hint,
    String? shortHint,
    required this.onValidationError,
  }) : super(
          hint: hint ?? '',
          shortHint: shortHint ?? '',
          errorMessage: '',
        );

  final ValueGetter<String?> onValidationError;

  @override
  String get errorMessage => onValidationError.call() ?? '';

  @override
  bool isValid(InputValidationState<T>? input) {
    return input is InputValidationSuccessState;
  }
}

class SwitchValidator extends AppInputValidator<bool> {
  SwitchValidator({
    String? hint,
    String? shortHint,
    String? errorMessage,
  }) : super(
            hint: hint ?? '',
            shortHint: shortHint ?? '',
            errorMessage: errorMessage ?? '');

  @override
  bool isValid(bool? input) {
    return input == true;
  }
}

class NonEmptyListValidator<T> extends AppInputValidator<List<T>> {
  NonEmptyListValidator({
    String? hint,
    String? shortHint,
    String? errorMessage})
      : super(
    hint: hint ?? '',
    shortHint: shortHint ??'',
    errorMessage: errorMessage ?? '',
  );

  @override
  bool isValid(List<T>? input) {
    return (input ?? []).isNotEmpty;
  }
}