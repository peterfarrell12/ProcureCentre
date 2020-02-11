//import 'package:ProcureCentre/projects/models/project.dart';
import 'dart:html';

import 'package:equatable/equatable.dart';

import '../../../project_repository.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class LoadProjects extends ProjectEvent {
  final String company;

  const LoadProjects(this.company);

  @override
  List<Object> get props => [company];

  @override
  String toString() => 'Load Projects {company: $company}';
}


class AddProject extends ProjectEvent {
  final Project project;
  final String company;

  const AddProject(this.project, this.company);

  @override
  List<Object> get props => [project, company];

  @override
  String toString() => 'AddProject { project: $project  company: $company}';
}
class AddProjectFile extends ProjectEvent {
  final Project project;
  final String company;
  final File file;

  const AddProjectFile(this.project, this.company, this.file);

  @override
  List<Object> get props => [project, company, file];

  @override
  String toString() => 'AddProjectFiles { ProjectFiles: $project  company: $company, file: $file}';
}

class UpdateProject extends ProjectEvent {
  final Project updatedProject;
  final String company;

  const UpdateProject(this.updatedProject, this.company);

  @override
  List<Object> get props => [updatedProject, company];

  @override
  String toString() => 'Updateproject { updatedproject: $updatedProject company: $company }';
}

class DeleteProject extends ProjectEvent {
  final Project project;
  final String company;

  const DeleteProject(this.project, this.company);

  @override
  List<Object> get props => [project, company];

  @override
  String toString() => 'DeleteProject { project: $project, company: $company }';
}

class ClearCompleted extends ProjectEvent {}

class ToggleAll extends ProjectEvent {}

class ProjectsUpdated extends ProjectEvent {
  final List<Project> projects;


  const ProjectsUpdated(this.projects);

  @override
  List<Object> get props => [Project];
}