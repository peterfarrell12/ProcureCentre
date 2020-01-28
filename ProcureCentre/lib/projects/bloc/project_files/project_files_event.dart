import 'package:equatable/equatable.dart';

import '../../../project_repository.dart';

abstract class ProjectFilesEvent extends Equatable {
  const ProjectFilesEvent();

  @override
  List<Object> get props => [];
}

class LoadProjectFiles extends ProjectFilesEvent {
  final String company;
  final Project project;

  const LoadProjectFiles(this.company, this.project);

  @override
  List<Object> get props => [company];

  @override
  String toString() => 'Load ProjectFiless {company: $company}';
}


class AddProjectFiles extends ProjectFilesEvent {
  final Project project;
  final String company;
  final String file;

  const AddProjectFiles(this.project, this.company, this.file);

  @override
  List<Object> get props => [project, company, file];

  @override
  String toString() => 'AddProjectFiles { ProjectFiles: $project  company: $company, file: $file}';
}

class UpdateProjectFiles extends ProjectFilesEvent {
  final Project updatedProject;
  final String company;
  final String file;

  const UpdateProjectFiles(this.updatedProject, this.company, this.file);

  @override
  List<Object> get props => [updatedProject, company, file];

  @override
  String toString() => 'UpdateProjectFiles { updatedProjectFiles: $updatedProject company: $company , file: $file}';
}

class DeleteProjectFiles extends ProjectFilesEvent {
  final Project project;
  final String company;
  final String file;

  const DeleteProjectFiles(this.project, this.company, this.file);

  @override
  List<Object> get props => [project, company, file];

  @override
  String toString() => 'DeleteProjectFiles { ProjectFiles: $project, company: $company, File: $file }';
}

class ClearCompleted extends ProjectFilesEvent {}

class ToggleAll extends ProjectFilesEvent {}

class ProjectFilesUpdated extends ProjectFilesEvent {
  final List<String> projectFiles;


  const ProjectFilesUpdated(this.projectFiles);

  @override
  List<Object> get props => [projectFiles];
}