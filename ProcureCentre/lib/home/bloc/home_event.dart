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

class DashboardButtonPressed extends HomeEvent {
  final User currentUser;

  const DashboardButtonPressed({@required this.currentUser});

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() => 'Dashboard Pressed { Current User :$currentUser }';
}

class SettingsButtonPressed extends HomeEvent {
  final User currentUser;

  const SettingsButtonPressed({@required this.currentUser});

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() => 'Project Pressed { Current User :$currentUser }';
}
