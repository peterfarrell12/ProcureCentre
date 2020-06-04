import 'dart:async';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CurrentProjectBloc
    extends Bloc<CurrentProjectEvent, CurrentProjectState> {
  @override
  CurrentProjectState get initialState => InitialCurrentProjectState();

  @override
  Stream<CurrentProjectState> mapEventToState(
    CurrentProjectEvent event,
  ) async* {
    if (event is GetCurrentProject) {
      yield* _mapGetCurrentProjectToState(event.project);
    } 
  }
}

 Stream<CurrentProjectState> _mapGetCurrentProjectToState(Project project) async* {
    yield  CurrentProjectLoaded(project);
    
  }

