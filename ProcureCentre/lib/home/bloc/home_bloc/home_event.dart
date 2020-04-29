import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class ProjectButtonPressed extends HomeEvent {
  final User currentUser;

  const ProjectButtonPressed({@required this.currentUser});

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() => 'Project Pressed { Current User :$currentUser }';
}

class HomeButtonPressed extends HomeEvent {
  final User currentUser;

  const HomeButtonPressed({@required this.currentUser});

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() => 'Home Pressed { Current User :$currentUser }';
}

class SettingsButtonPressed extends HomeEvent {
  final User currentUser;

  const SettingsButtonPressed({@required this.currentUser});

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() => 'Project Pressed { Current User :$currentUser }';
}
