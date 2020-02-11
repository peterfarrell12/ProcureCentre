import 'dart:async';
import 'package:ProcureCentre/extraction/extraction_repository.dart';
import 'package:ProcureCentre/extraction/widgets/service.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';




class ExtractionBloc extends Bloc<ExtractionEvent, ExtractionState> {
 //final Project _project;

  // ExtractionBloc({@required Project project})
  //     : assert(project != null),
  //       _project = project;

  final ExtractionRepository _extractionRepository;
  ExtractionBloc({@required ExtractionRepository extractionRepository})
      : assert(extractionRepository != null),
        _extractionRepository = extractionRepository;
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
      
    }  else if (event is AddDataPressed) {
      yield* _mapAddDataPressedToState(event.project);
    }
    else if (event is CheckingStatus) {
      yield* _mapCheckDataToState(event.project);
    }
    else if (event is ExtractBegin) {
      yield* _mapExtractingToState(event);

  }
      else if (event is DeleteData) {
      yield* _mapDeleteDataToState();

  }
    else  if (event is NotExtracted){
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

   Stream<ExtractionState> _mapExtractCompleteToState(ExtractComplete event) async* {
    yield  ExtractedState(event.project);
    
  }
   Stream<ExtractionState> _mapNotExtractedToState(NotExtracted event) async* {
    yield  NotExtractedState(event.project);
    
  }

   Stream<ExtractionState> _mapAddDataPressedToState(Project project) async* {
    yield  NotExtractedState(project);
    
  }

  Stream<ExtractionState> _mapCheckDataToState(Project project) async* {
    try {
      final bool status = project.extraction['Completed'];
      print(status);
      if(status){
        print(status);
        yield ExtractedState(project);
      } else {
        yield NotExtractedState(project);
      }
    } catch (_) {
      yield NotExtractedState(project);
    }
    
  }

   Stream<ExtractionState> _mapDeleteDataToState() async* {
    //yield  NotExtractedState(event.project);
    
  }

  Stream<ExtractionState> _mapExtractingToState(ExtractBegin event) async* {
    yield ExtractingState();
    String url = await _extractionRepository.addFileToFirebase(event.project, event.company, event.file);
    await sendFile(event.rResult, event.fileName);
    //TODO -> Await Completed Extraction;
    //TODO -> Add Extracted Data To Firebase
    yield  ExtractedState(event.project);
  }



  //  Stream<ExtractionState> _mapUploadFilePressedToState(Project project) async* {
  //   yield  ExtractNewFileState(project);
    
  // }

  //  Stream<ExtractionState> _mapOtherFilePressedToState(Project project) async* {
  //   yield  ExtractOtherFileState(project);
    
  // }

  //    Stream<ExtractionState> _mapExtractPressedToState(Project project) async* {
  //   yield  ExtractingState(project);
    
  // }

  

}

