import 'package:ProcureCentre/projects/models/models.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:equatable/equatable.dart';


abstract class FilteredProjectState extends Equatable {
  const FilteredProjectState();

  @override
  List<Object> get props => [];
}

class FilteredProjectLoading extends FilteredProjectState {}

class FilteredProjectLoaded extends FilteredProjectState {
  final List<Project> filteredProject;
  final VisibilityFilter activeFilter;

  const FilteredProjectLoaded(
    this.filteredProject,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredProject, activeFilter];

  @override
  String toString() {
    return 'FilteredProjectLoaded { filteredProject: $filteredProject, activeFilter: $activeFilter }';
  }
}
