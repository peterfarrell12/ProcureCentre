import 'dart:async';

import 'package:ProcureCentre/extraction/extraction_repository.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:ProcureCentre/projects/projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ExtractionRepository _extractionRepository;
    final ProjectRepository _projectRepository;
  


  DashboardBloc(
      {@required ExtractionRepository extractionRepository,
      @required ProjectRepository projectRepository})
      : assert(extractionRepository != null && projectRepository != null),
        _extractionRepository = extractionRepository,
        _projectRepository = projectRepository;
  @override
  DashboardState get initialState => DashboardInitial();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if(event is DashboardLoading){
      yield* _mapDashboardLoadingToState(event);
    }
    // else if(event is DashboardLoaded){
    //   yield* _mapDashboardLoadedToState(event);
    // }
  }

   Stream<DashboardState>_mapDashboardLoadingToState(DashboardLoading event) async* {

     List<DataPoint> data =  await _extractionRepository.getData(event.project, event.company);
    yield DashboardLoadedState(event.project, data);
  }


  //  Stream<DashboardState>_mapDashboardLoadedToState(DashboardLoading event) async* {

  //    //List<DataPoint> data =  await _extractionRepository.getData(event.project, event.company);
  //   yield DashboardLoadedState(event.project, data);
  // }
}
