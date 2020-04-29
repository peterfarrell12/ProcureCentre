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
import 'package:equatable/equatable.dart';

import 'bloc.dart';

class ExtractionBloc extends Bloc<ExtractionEvent, ExtractionState> {
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
    if (event is CheckingStatus) {
      yield* _mapCheckingStatusToState(event);
    } else if (event is ExtractDataPressed) {
      yield* _mapExtractDataPressedToState(event);
    } else if (event is UploadFilesPressed) {
      yield* _mapUploadFilesPressedToState(event);
    } else if (event is DeleteDataPressed) {
      yield* _mapDeleteDataPressedToState(event);
    } else if (event is ClassificationPressed) {
      yield* _mapClassificationPressedToState(event);
    } else if (event is NewExtractPressed) {
      yield* _mapNewExtractPressedToState(event);
    }
  }

  Stream<ExtractionState> _mapCheckingStatusToState(
      CheckingStatus event) async* {
    yield CheckingStatusState(event.project, event.company);
    int stage = event.project.extraction['Stage'];
    yield StatusCheckedState(event.project, event.company, stage);
  }

  Stream<ExtractionState> _mapUploadFilesPressedToState(
      UploadFilesPressed event) async* {
    yield CheckingStatusState(event.project, event.company);

    try {
      List<String> names = [];
      for (int i = 0; i < event.file.length; i++) {
        names.add(event.file[i].name);
      }
      await sendFile(event.rResult, names);
      for (int x = 0; x < event.file.length; x++) {
        String url = await _extractionRepository.addFileToFirebase(
            event.project, event.company, event.file[x]);
      }
      Project updateProject = event.project.copyWith(
        extraction: {'Stage': 2, 'Completed': false},
      );
      await _projectRepository.updateProject(updateProject, event.company);
      print(updateProject.id);
      yield StatusCheckedState(updateProject, event.company, 2);
    } catch (e) {
      print('Error Caught');
    }
  }

  Stream<ExtractionState> _mapExtractDataPressedToState(
      ExtractDataPressed event) async* {
    List<DataPoint> newItems =
        await retrieveData(event.startTime, event.endTime, event.project);
    print(newItems);
    await _extractionRepository.addData(event.project, event.company, newItems);
    Project updateProject =
        event.project.copyWith(extraction: {'Completed': true, 'Stage': 3});
    await _projectRepository.updateProject(updateProject, event.company);
    print(newItems);
    //print(updateProject.id);
    //yield StatusCheckedState(updateProject, event.company, 3);
  }

  Stream<ExtractionState> _mapDeleteDataPressedToState(
      DeleteDataPressed event) async* {}

  Stream<ExtractionState> _mapClassificationPressedToState(
      ClassificationPressed event) async* {}

  Stream<ExtractionState> _mapNewExtractPressedToState(
      NewExtractPressed event) async* {
    Project updateProject =
        event.project.copyWith(extraction: {'Completed': false, 'Stage': 1});
    await _projectRepository.updateProject(updateProject, event.company);

    yield StatusCheckedState(updateProject, event.company, 1);
  }

  // Stream<ExtractionState> _mapExtractCompleteToState(
  //     ExtractComplete event) async* {
  //   yield ExtractedState(event.project, event.data);
  // }

  // Stream<ExtractionState> _mapNotExtractedToState(NotExtracted event) async* {
  //   yield NotExtractedState(event.project);
  // }

  // Stream<ExtractionState> _mapAddDataPressedToState(Project project) async* {
  //   yield NotExtractedState(project);
  // }

  // Stream<ExtractionState> _mapCheckDataToState(CheckingStatus event) async* {
  //   try {
  //     final bool status = event.project.extraction['Completed'];
  //     print(status);
  //     if (status) {
  //       print(status);
  //       List<DataPoint> data =
  //           await _extractionRepository.getData(event.project, event.company);
  //       yield ExtractedState(event.project, data);
  //     } else {
  //       yield NotExtractedState(event.project);
  //     }
  //   } catch (_) {
  //     yield NotExtractedState(event.project);
  //   }
  // }

  // Stream<ExtractionState> _mapAddDataToState(AddDataPressed event) async* {
  //   print('add data');
  //     print('hello');
  //      bool completed = event.project.extraction['Completed'];
  //         print(completed);
  //         Project updateProject = event.project.copyWith(extraction: {'Completed' : !completed});
  //         await _projectRepository.updateProject(updateProject, event.company);
  //     yield NotExtractedState(event.project);

  // }

  // Stream<ExtractionState> _mapDeleteDataToState(DeleteData event) async* {
  //   //yield  NotExtractedState(event.project);
  // await _extractionRepository.deleteProject(event.project, event.company, event.ids);
  // yield StateLoading();

  // }
  // Stream<ExtractionState> _mapCheckFilesToState() async* {
  //   yield CheckingFilesState();
  // }

  // Stream<ExtractionState> _mapFilesCheckedToState(FilesChecked event) async* {
  //   // _projectRepository.updateProject(event.updatedProject, event.company);
  //   yield ExtractingState();

  //   _extractionRepository.addData(event.project, event.company, event.data);
  //   var data =
  //       await _extractionRepository.getData(event.project, event.company);
  //   print(data[0].invoice);
  //   yield ExtractedState(event.project, data);
  // }

  // Stream<ExtractionState> _mapRetrieveFilesToState(RetrieveFiles event) async* {
  //   yield ExtractingState();
  //   List<DataPoint> newItems =
  //       await retrieveData(event.startTime, event.endTime, event.project);
  //   bool completed = event.project.classification['Completed'];
  //         print(completed);
  //         Project updateProject = event.project.copyWith(classification: {'Completed' : !completed});
  //         await _projectRepository.updateProject(updateProject, event.company);
  //   yield FilesCheckedState(items: newItems);
  // }

  // Stream<ExtractionState> _mapExtractingToState(ExtractBegin event) async* {
  //   yield ExtractingState();
  //   print(event.rResult);
  //   for (int x = 0; x < event.file.length; x++) {
  //     String url = await _extractionRepository.addFileToFirebase(
  //         event.project, event.company, event.file[x]);

  //   }
  //   List<String> names = [];
  //   for (int i = 0; i < event.file.length; i++){
  //     names.add(event.file[i].name);
  //   }
  //   await sendFile(event.rResult, names );

  //   yield CheckingFilesState();
  // }
}
