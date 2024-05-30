import 'package:flutter/material.dart';
import 'package:todo_app/common/theme/size_config.dart';

abstract class InputValidationState<T> {
  const InputValidationState({this.input, this.response, this.errorMessage});

  final String? input;
  final T? response;
  final String? errorMessage;

  Widget render() => const SizedBox.shrink();

  InputValidationState<T> copyWith({
    String? input,
    T? response,
    String? errorMessage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InputValidationState &&
          runtimeType == other.runtimeType &&
          input == other.input &&
          response == other.response &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      input.hashCode ^ response.hashCode ^ errorMessage.hashCode;
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class InputValidationDefaultState<T> extends InputValidationState<T> {
  const InputValidationDefaultState(
      {super.input, super.response, super.errorMessage});

  @override
  InputValidationDefaultState<T> copyWith({
    String? input,
    T? response,
    String? errorMessage,
  }) {
    return InputValidationDefaultState<T>(
      input: input ?? this.input,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class InputValidationLoadingState<T> extends InputValidationState<T> {
  const InputValidationLoadingState(
      {super.input, super.response, super.errorMessage});

  @override
  Widget render() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: SizeConfig.radius(16),
          height: SizeConfig.radius(16),
          child: const SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
      ],
    );
  }

  @override
  InputValidationLoadingState<T> copyWith({
    String? input,
    T? response,
    String? errorMessage,
  }) {
    return InputValidationLoadingState<T>(
      input: input ?? this.input,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class InputValidationSuccessState<T> extends InputValidationState<T> {
  const InputValidationSuccessState(
      {super.input, super.response, super.errorMessage});

  @override
  InputValidationSuccessState<T> copyWith({
    String? input,
    T? response,
    String? errorMessage,
  }) {
    return InputValidationSuccessState<T>(
      input: input ?? this.input,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class InputValidationErrorState<T> extends InputValidationState<T> {
  const InputValidationErrorState(
      {super.input, super.response, super.errorMessage});

  @override
  InputValidationErrorState<T> copyWith({
    String? input,
    T? response,
    String? errorMessage,
  }) {
    return InputValidationErrorState<T>(
      input: input ?? this.input,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
