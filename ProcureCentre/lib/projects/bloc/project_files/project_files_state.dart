import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../project_repository.dart';

@immutable
abstract class ProjectFilesState extends Equatable {
  const ProjectFilesState();

  @override
  List<Object> get props => [];
}

class ProjectFilesLoading extends ProjectFilesState {}

class ProjectFilesLoaded extends ProjectFilesState {
  final List<String> projectFiles;

  const ProjectFilesLoaded([this.projectFiles = const []]);

  @override
  List<Object> get props => [projectFiles];

  @override
  String toString() => 'ProjectFilesLoaded { ProjectFiles: $projectFiles }';
}

class ProjectFilesNotLoaded extends ProjectFilesState {}

