import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isDisplayNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid && isDisplayNameValid;


  RegisterState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isDisplayNameValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isDisplayNameValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isDisplayNameValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isDisplayNameValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isDisplayNameValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isDisplayNameValid

  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isDisplayNameValid : isDisplayNameValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isDisplayNameValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isDisplayNameValid: isDisplayNameValid ?? this.isDisplayNameValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isDisplayNameValid: $isDisplayNameValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
