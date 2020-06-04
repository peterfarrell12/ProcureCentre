import 'package:ProcureCentre/projects/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class CurrentProjectEvent extends Equatable {
  const CurrentProjectEvent();
}

class GetCurrentProject extends CurrentProjectEvent {
  final Project project;

  const GetCurrentProject(this.project);

  @override
  List<Object> get props => [project];

   @override
  String toString() => 'getCurrentProject { project: ${project.name}}';
}

