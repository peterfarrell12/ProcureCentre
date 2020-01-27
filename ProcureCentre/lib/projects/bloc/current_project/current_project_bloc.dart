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
    // else if (event is ShowTimeline) {
    //   yield* _mapShowTimelineToState(event.project);
    // } else if (event is GetDataExtraction) {
    //   yield* _mapGetDataExtractionToState(event.project);
    // } else if (event is GetClassification) {
    //   yield* _mapGetClassificationToState(event.project);
    // } else if (event is GetDashboard) {
    //   yield* _mapGetDashboardToState(event.project);
    // } else if (event is GetTenderCreation) {
    //   yield* _mapGetTenderCreationToState(event.project);
    // }
  }
}

 Stream<CurrentProjectState> _mapGetCurrentProjectToState(Project project) async* {
    yield  CurrentProjectLoaded(project);
    
  }
  // Stream<CurrentProjectState> _mapShowTimelineToState(Project project) async* {
  //   yield  CurrentProjectLoaded(project);
    
  // }
  // Stream<CurrentProjectState> _mapGetDataExtractionToState(Project project) async* {
  //   yield  ShowDataExtraction(project);
    
  // }
  // Stream<CurrentProjectState> _mapGetClassificationToState(Project project) async* {
  //   yield  ShowClassification(project);
    
  // }
  // Stream<CurrentProjectState> _mapGetDashboardToState(Project project) async* {
  //   yield  ShowDashboard(project);
    
  // }
  // Stream<CurrentProjectState> _mapGetTenderCreationToState(Project project) async* {
  //   yield  ShowTenderCreation(project);
    
  // }
