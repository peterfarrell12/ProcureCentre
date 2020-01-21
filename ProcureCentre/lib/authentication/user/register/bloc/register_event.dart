import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}
class DisplayNameChanged extends RegisterEvent {
  final String displayName;

  const DisplayNameChanged({@required this.displayName});

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Display Name Changed:  { display name: $displayName }';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;
  final String displayName;
  final String company;

  const Submitted({
    @required this.email,
    @required this.password,
    @required this.displayName,
    @required this.company
  });

  @override
  List<Object> get props => [email, password,displayName];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password, display name: $displayName, company name: $company }';
  }
}
