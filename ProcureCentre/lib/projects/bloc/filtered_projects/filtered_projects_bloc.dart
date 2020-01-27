import 'dart:async';
import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:ProcureCentre/projects/bloc/projects/projects_bloc.dart';
import 'package:ProcureCentre/projects/bloc/projects/projects_state.dart';
import 'package:ProcureCentre/projects/models/models.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'bloc.dart';

class FilteredProjectsBloc extends Bloc<FilteredProjectsEvent, FilteredProjectState> {
  final ProjectsBloc _projectsBloc;
  final User _user;
  StreamSubscription _projectsSubscription;

  FilteredProjectsBloc({@required ProjectsBloc projectsBloc, @required User user})
      : assert(projectsBloc != null && user != null),
        _user = user,
        _projectsBloc = projectsBloc {
    _projectsSubscription = projectsBloc.listen((state) {
      if (state is ProjectsLoaded) {
        add(UpdateProjects((projectsBloc.state as ProjectsLoaded).projects));
      }
    });
  }

  @override
  FilteredProjectState get initialState {
    final currentState = _projectsBloc.state;
    return currentState is ProjectsLoaded
        ? FilteredProjectLoaded(currentState.projects, VisibilityFilter.all)
        : FilteredProjectLoading();
  }

  @override
  Stream<FilteredProjectState> mapEventToState(FilteredProjectsEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateProjects) {
      yield* _mapProjectsUpdatedToState(event);
    }
  }

  Stream<FilteredProjectState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    final currentState = _projectsBloc.state;
    if (currentState is ProjectsLoaded) {
      yield FilteredProjectLoaded(
        _mapProjectsToFilteredProjects(currentState.projects, event.filter, event.user),
        event.filter,
      );
    }
  }

  Stream<FilteredProjectState> _mapProjectsUpdatedToState(
    UpdateProjects event,
  ) async* {
    final visibilityFilter = state is FilteredProjectLoaded
        ? (state as FilteredProjectLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredProjectLoaded(
      _mapProjectsToFilteredProjects(
        (_projectsBloc.state as ProjectsLoaded).projects,
        visibilityFilter,
        _user
      ),
      visibilityFilter,
    );
  }

  List<Project> _mapProjectsToFilteredProjects(
      List<Project> projects, VisibilityFilter filter, User currentUser) {
    return projects.where((project) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !project.complete;
      }
        else if (filter == VisibilityFilter.user) {
        return project.user == currentUser.username;
      } else {
        return project.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _projectsSubscription?.cancel();
    return super.close();
  }
}
