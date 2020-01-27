import 'package:ProcureCentre/projects/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class UpdateStats extends StatsEvent {
  final List<Project> projects;

  const UpdateStats(this.projects);

  @override
  List<Object> get props => [projects];

  @override
  String toString() => 'UpdateStats { projects: $projects }';
}