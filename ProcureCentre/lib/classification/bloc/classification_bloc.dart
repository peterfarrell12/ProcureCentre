import 'dart:async';

import 'package:ProcureCentre/extraction/extraction_repository.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'classification_event.dart';
part 'classification_state.dart';

class ClassificationBloc
    extends Bloc<ClassificationEvent, ClassificationState> {
  final ExtractionRepository _extractionRepository;

  ClassificationBloc({
    @required ExtractionRepository extractionRepository,
  })  : assert(extractionRepository != null),
        _extractionRepository = extractionRepository;

  @override
  ClassificationState get initialState => StateLoading();

  @override
  Stream<ClassificationState> mapEventToState(
    ClassificationEvent event,
  ) async* {
    if (event is ClassificationComplete) {
      yield* _mapClassificationCompleteToState(event);
    } else if (event is NotClassified) {
      yield* _mapNotClassifiedToState(event);
    } else if (event is CheckingStatus) {
      yield* _mapCheckingStatusToState(event);
    } else if (event is ClassificationBegin) {
      yield* _mapClassificactionBeginToState(event);
    }

    // TODO: Add Logic
  }

  _mapClassificationCompleteToState(ClassificationComplete event) {}

  _mapNotClassifiedToState(NotClassified event) {}

  _mapCheckingStatusToState(CheckingStatus event) {}

  _mapClassificactionBeginToState(ClassificationBegin event) {}
}
