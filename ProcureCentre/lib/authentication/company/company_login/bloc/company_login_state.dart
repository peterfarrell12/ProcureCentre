import 'package:meta/meta.dart';

@immutable
class CompanyLoginState {
  final bool isPINValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isPINValid;

  CompanyLoginState({
    @required this.isPINValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory CompanyLoginState.empty() {
    return CompanyLoginState(
      isPINValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory CompanyLoginState.loading() {
    return CompanyLoginState(
      isPINValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory CompanyLoginState.failure() {
    return CompanyLoginState(
      isPINValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory CompanyLoginState.success() {
    return CompanyLoginState(
      isPINValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  CompanyLoginState update({
    bool isPINValid,
  }) {
    return copyWith(
      isPINValid: isPINValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  CompanyLoginState copyWith({
    bool isPINValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return CompanyLoginState(
      isPINValid: isPINValid ?? this.isPINValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isPINValid: $isPINValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
