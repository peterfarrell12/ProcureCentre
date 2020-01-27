import 'dart:async';
import 'package:ProcureCentre/projects/models/models.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  @override
  SidebarState get initialState => InitialSidebarState();

  @override
  Stream<SidebarState> mapEventToState(
    SidebarEvent event,
  ) async* {
    if (event is GetTimeline) {
      yield* _mapShowTimelineToState(event.project);
    } else if (event is GetDataExtraction) {
      yield* _mapGetDataExtractionToState(event.project);
    } else if (event is GetClassification) {
      yield* _mapGetClassificationToState(event.project);
    } else if (event is GetDashboard) {
      yield* _mapGetDashboardToState(event.project);
    } else if (event is GetTenderCreation) {
      yield* _mapGetTenderCreationToState(event.project);
    }
  }
}

Stream<SidebarState> _mapShowTimelineToState(Project project) async* {
  yield ShowTimeline(project);
}

Stream<SidebarState> _mapGetDataExtractionToState(
    Project project) async* {
  yield ShowDataExtraction(project);
}

Stream<SidebarState> _mapGetClassificationToState(
    Project project) async* {
  yield ShowClassification(project);
}

Stream<SidebarState> _mapGetDashboardToState(Project project) async* {
  yield ShowDashboard(project);
}

Stream<SidebarState> _mapGetTenderCreationToState(
    Project project) async* {
  yield ShowTenderCreation(project);
}
