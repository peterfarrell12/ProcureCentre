import 'package:equatable/equatable.dart';

abstract class ProjectsState extends Equatable {
  const ProjectsState();
}

class InitialProjectsState extends ProjectsState {
  @override
  List<Object> get props => [];
}
