part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoadingState extends DashboardState {
  final Project project;
  final String company;

    const DashboardLoadingState(this.project, this.company);

  @override
  List<Object> get props => [project, company];

  String toString() => "Dashboard Loading.....";
}

class DashboardLoadedState extends DashboardState {
   final Project project;
   final List<DataPoint> data;


  const DashboardLoadedState(this.project, this.data);

  @override
  List<Object> get props => [project, data];

  @override
  String toString() => 'Dashboard Loaded { Project: ${project.name} }';

}
