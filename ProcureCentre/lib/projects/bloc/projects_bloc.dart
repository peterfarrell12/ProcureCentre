import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  @override
  ProjectsState get initialState => InitialProjectsState();

  @override
  Stream<ProjectsState> mapEventToState(
    ProjectsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
