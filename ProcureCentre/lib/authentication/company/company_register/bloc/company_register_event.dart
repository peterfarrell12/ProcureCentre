import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CompanyRegisterEvent extends Equatable {
  const CompanyRegisterEvent();

  @override
  List<Object> get props => [];
}

class CompanyNameChanged extends CompanyRegisterEvent {
  final String name;

  const CompanyNameChanged({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'CompanyNameChanged { name :$name }';
}

class CompanyPinChanged extends CompanyRegisterEvent {
  final String pin;

  const CompanyPinChanged({@required this.pin});

  @override
  List<Object> get props => [pin];

  @override
  String toString() => 'Pin Changed { pin: $pin }';
}

class CompanyAbbChanged extends CompanyRegisterEvent {
  final String abb;

  const CompanyAbbChanged({@required this.abb});

  @override
  List<Object> get props => [abb];

  @override
  String toString() => 'Abb Changed:  { display name: $abb }';
}

class CompanySubmitted extends CompanyRegisterEvent {
  final String name;
  final String pin;
  final String abb;

  const CompanySubmitted(
      {@required this.name, @required this.pin, @required this.abb});

  @override
  List<Object> get props => [name, pin, abb];

  @override
  String toString() {
    return 'Submitted { name: $name, pin: $pin display name: $abb }';
  }
}
