import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../project_repository.dart';

@immutable
abstract class ProjectsState extends Equatable {
  const ProjectsState();

  @override
  List<Object> get props => [];
}

class ProjectsLoading extends ProjectsState {}

class ProjectsLoaded extends ProjectsState {
  final List<Project> projects;

  const ProjectsLoaded([this.projects = const []]);

  @override
  List<Object> get props => [projects];

  @override
  String toString() => 'ProjectsLoaded { Projects: $projects }';
}

class ProjectsNotLoaded extends ProjectsState {}
