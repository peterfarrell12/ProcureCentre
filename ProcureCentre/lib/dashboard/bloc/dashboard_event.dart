part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class DashboardLoading extends DashboardEvent {
  final Project project;
  final String company;

  const DashboardLoading({@required this.project, @required this.company});

  @override
  List<Object> get props => [project, company];

  @override
  String toString() => 'Dashboard Loading Has Begun { Project :${project.name}, }';
}

class DashboardLoaded extends DashboardEvent {
  final Project project;
  final List<DataPoint> data;

  const DashboardLoaded({@required this.project, @required this.data});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Dashboard Has Begun { Project :${project.name},}';
}