import 'package:meta/meta.dart';

@immutable
class CompanyRegisterState {
  final bool isNameValid;
  final bool isPINValid;
  final bool isAbbValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isNameValid && isPINValid && isAbbValid;


  CompanyRegisterState({
    @required this.isNameValid,
    @required this.isPINValid,
    @required this.isAbbValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory CompanyRegisterState.empty() {
    return CompanyRegisterState(
      isNameValid: true,
      isPINValid: true,
      isAbbValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory CompanyRegisterState.loading() {
    return CompanyRegisterState(
      isNameValid: true,
      isPINValid: true,
      isAbbValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory CompanyRegisterState.failure() {
    return CompanyRegisterState(
      isNameValid: true,
      isPINValid: true,
      isAbbValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory CompanyRegisterState.success() {
    return CompanyRegisterState(
      isNameValid: true,
      isPINValid: true,
      isAbbValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  CompanyRegisterState update({
    bool isNameValid,
    bool isPINValid,
    bool isAbbValid

  }) {
    return copyWith(
      isNameValid: isNameValid,
      isPINValid: isPINValid,
      isAbbValid : isAbbValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  CompanyRegisterState copyWith({
    bool isNameValid,
    bool isPINValid,
    bool isAbbValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return CompanyRegisterState(
      isNameValid: isNameValid ?? this.isNameValid,
      isPINValid: isPINValid ?? this.isPINValid,
      isAbbValid: isAbbValid ?? this.isAbbValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''CompanyRegisterState {
      isNameValid: $isNameValid,
      isPINValid: $isPINValid,
      isAbbValid: $isAbbValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}

