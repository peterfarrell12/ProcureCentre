import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CompanyLoginEvent extends Equatable {
  const CompanyLoginEvent();

  @override
  List<Object> get props => [];
}

class CompanyNameChanged extends CompanyLoginEvent {
  final String companyName;

  const CompanyNameChanged({@required this.companyName});

  @override
  List<Object> get props => [companyName];

  @override
  String toString() => 'Company Name Changed { name :$companyName}';
}

class PINChanged extends CompanyLoginEvent {
  final String pin;

  const PINChanged({@required this.pin});

  @override
  List<Object> get props => [pin];

  @override
  String toString() => 'PIN Changed { PIN: $pin }';
}

class Submitted extends CompanyLoginEvent {
  final String companyName;
  final String pin;

  const Submitted({
    @required this.companyName,
    @required this.pin,
  });

  @override
  List<Object> get props => [companyName, pin];

  @override
  String toString() {
    return 'Submitted { companyName: $companyName, companyPIN: $pin }';
  }
}


class LoginWithCompanyCredentialsPressed extends CompanyLoginEvent {
  final String companyName;
  final String pin;


  const LoginWithCompanyCredentialsPressed({
    @required this.companyName,
    @required this.pin,
  });

   @override
  List<Object> get props => [companyName, pin];

  @override
  String toString() {
    return 'LoginWithCompanyCredentialsPressed { companyName: $companyName, companyPIN: $pin }';
  }
}
