

import 'package:ProcureCentre/extraction/extraction_repository.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:ProcureCentre/projects/projects_repository.dart';
import 'package:ProcureCentre/tender/models/tender.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../tender_repository.dart';
part 'tender_event.dart';

part 'tender_state.dart';

class TenderBloc
    extends Bloc<TenderEvent, TenderState> {
  final TenderRepository _tenderRepository;
    final ProjectRepository _projectRepository;


  TenderBloc(
      {@required TenderRepository tenderRepository,
      @required ProjectRepository projectRepository})
      : assert(tenderRepository != null && projectRepository != null),
        _tenderRepository = tenderRepository,
        _projectRepository = projectRepository;

  @override
  TenderState get initialState => StateLoading();

  @override
  Stream<TenderState> mapEventToState(
    TenderEvent event,
  ) async* {
    // if (event is TenderCreated) {
    //   yield* _mapTenderCreatedToState(event);
    // } else
     if (event is TenderNotCreated) {
      yield* _mapTenderNotCreatedToState(event);
    } else if (event is CheckingStatus) {
      yield* _mapCheckingStatusToState(event);
    } else if (event is TenderBegin) {
      yield* _mapTenderBeginToState(event);
    }
    else if (event is TenderChosen) {
      yield* _mapTenderChosenToState(event);
    }
  }

  // Stream<TenderState> _mapTenderCreatedToState(TenderCreated event)  async* {
  //   yield TenderCreatedState(event.project, event.company);
  // }
   Stream<TenderState> _mapTenderNotCreatedToState(TenderNotCreated event) async* {
    yield TenderNotCreatedState(event.project, event.company);
  }
   Stream<TenderState> _mapCheckingStatusToState(CheckingStatus event)async* {
    int len = await _tenderRepository.getLength(event.project, event.company);
    print(len);
    if(len == 0) {
      yield TenderNotCreatedState(event.project, event.company);
    } 
    else {
      List<Tender> tenderList = await _tenderRepository.getTenders(event.project, event.company);
      print(tenderList.length);
      yield TenderCreatedState(event.project, event.company, tenderList);
    }
  }
   Stream<TenderState> _mapTenderBeginToState(TenderBegin event) async* {
    yield CreatingTenderState();
    await _tenderRepository.addTender(event.project, event.company, event.tender);
    List<DataPoint> data = await _tenderRepository.getDataPoints(event.project, event.company, event.tender.dPReferences);
    yield ViewingTenderState(event.tender, data);
  }

  Stream<TenderState> _mapTenderChosenToState(TenderChosen event) async* {
        List<DataPoint> data = await _tenderRepository.getDataPoints(event.project, event.tender.company, event.tender.dPReferences);

    yield ViewingTenderState(event.tender, data);
  }

    }

