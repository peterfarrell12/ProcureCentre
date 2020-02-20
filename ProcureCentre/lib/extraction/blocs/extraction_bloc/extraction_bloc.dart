import 'dart:async';
import 'package:ProcureCentre/extraction/extraction_repository.dart';
import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/extraction/widgets/service.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:ProcureCentre/projects/projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

class ExtractionBloc extends Bloc<ExtractionEvent, ExtractionState> {
  //final Project _project;

  // ExtractionBloc({@required Project project})
  //     : assert(project != null),
  //       _project = project;

  final ExtractionRepository _extractionRepository;
  final ProjectRepository _projectRepository;
  ExtractionBloc(
      {@required ExtractionRepository extractionRepository,
      @required ProjectRepository projectRepository})
      : assert(extractionRepository != null && projectRepository != null),
        _extractionRepository = extractionRepository,
        _projectRepository = projectRepository;
  @override
  ExtractionState get initialState => StateLoading();

  @override
  Stream<ExtractionState> mapEventToState(
    ExtractionEvent event,
  ) async* {
    // if(event is ExtractStarted){
    //   yield* _mapExtractStartedToState(event.project);
    // }
    if (event is ExtractComplete) {
      yield* _mapExtractCompleteToState(event);
    } else if (event is AddDataPressed) {
      yield* _mapAddDataPressedToState(event.project);
    } else if (event is CheckingStatus) {
      yield* _mapCheckDataToState(event);
    }
    // else if (event is CheckingFiles) {
    //   yield* _mapCheckDataToState(event);
    // }
    else if (event is FilesChecked) {
      yield* _mapFilesCheckedToState(event);
    } else if (event is ExtractBegin) {
      yield* _mapExtractingToState(event);
    } else if (event is RetrieveFiles) {
      yield* _mapRetrieveFilesToState(event);
    } else if (event is DeleteData) {
      yield* _mapDeleteDataToState();
    } else if (event is NotExtracted) {
      yield* _mapNotExtractedToState(event);
    }
  }

  // Stream<ExtractionState> _mapExtractStartedToState(Project project)  async*{
  //   try {
  //     final isCompleted = project.extraction['Completed'];
  //     if(isCompleted){
  //       yield ExtractionCompletedState(project);
  //     } else {
  //       yield ExtractionNotCompletedState(project);
  //     }
  //   } catch (_) {
  //     yield ExtractionNotCompletedState(project);
  //   }
  // }

  Stream<ExtractionState> _mapExtractCompleteToState(
      ExtractComplete event) async* {
    yield ExtractedState(event.project, event.data);
  }

  Stream<ExtractionState> _mapNotExtractedToState(NotExtracted event) async* {
    yield NotExtractedState(event.project);
  }

  Stream<ExtractionState> _mapAddDataPressedToState(Project project) async* {
    yield NotExtractedState(project);
  }

  Stream<ExtractionState> _mapCheckDataToState(CheckingStatus event) async* {
    try {
      final bool status = event.project.extraction['Completed'];
      print(status);
      if (status) {
        print(status);
        List<DataPoint> data =
            await _extractionRepository.getData(event.project, event.company);
        yield ExtractedState(event.project, data);
      } else {
        yield NotExtractedState(event.project);
      }
    } catch (_) {
      yield NotExtractedState(event.project);
    }
  }

  Stream<ExtractionState> _mapDeleteDataToState() async* {
    //yield  NotExtractedState(event.project);
  }
  Stream<ExtractionState> _mapCheckFilesToState() async* {
    yield CheckingFilesState();
  }

  Stream<ExtractionState> _mapFilesCheckedToState(FilesChecked event) async* {
    // _projectRepository.updateProject(event.updatedProject, event.company);
    yield ExtractingState();

    _extractionRepository.addData(event.project, event.company, event.data);
    var data =
        await _extractionRepository.getData(event.project, event.company);
    print(data[0].invoice);
    yield ExtractedState(event.project, data);
  }

  Stream<ExtractionState> _mapRetrieveFilesToState(RetrieveFiles event) async* {
    yield ExtractingState();
    List<DataPoint> newItems =
        await retrieveData(event.startTime, event.endTime, event.project);
    yield FilesCheckedState(items: newItems);
  }

  Stream<ExtractionState> _mapExtractingToState(ExtractBegin event) async* {
    yield ExtractingState();
    print(event.rResult);
    for (int x = 0; x < event.file.length; x++) {
      String url = await _extractionRepository.addFileToFirebase(
          event.project, event.company, event.file[x]);
      await sendFile(event.rResult, event.file[x].name);
    }

    yield CheckingFilesState();
  }
}
