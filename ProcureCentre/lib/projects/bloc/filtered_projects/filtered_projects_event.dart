import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:ProcureCentre/projects/models/models.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:equatable/equatable.dart';


abstract class FilteredProjectsEvent extends Equatable {
  const FilteredProjectsEvent();
}

class UpdateFilter extends FilteredProjectsEvent {
  final VisibilityFilter filter;
    final User user;


  const UpdateFilter(this.filter, this.user);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

class UpdateProjects extends FilteredProjectsEvent {
  final List<Project> projects;

  const UpdateProjects(this.projects,);

  @override
  List<Object> get props => [projects];

  @override
  String toString() => 'UpdateProjects { Projects: $projects }';
}
