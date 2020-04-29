import 'dart:async';

import 'package:ProcureCentre/classification/widgets/service.dart';
import 'package:ProcureCentre/extraction/extraction_repository.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/project_repository.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:ProcureCentre/projects/projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'classification_event.dart';
part 'classification_state.dart';

class ClassificationBloc
    extends Bloc<ClassificationEvent, ClassificationState> {
  final ExtractionRepository _extractionRepository;
  final ProjectRepository _projectRepository;

  ClassificationBloc(
      {@required ExtractionRepository extractionRepository,
      @required ProjectRepository projectRepository})
      : assert(extractionRepository != null && projectRepository != null),
        _extractionRepository = extractionRepository,
        _projectRepository = projectRepository;

  @override
  ClassificationState get initialState => StateLoading();

  @override
  Stream<ClassificationState> mapEventToState(
    ClassificationEvent event,
  ) async* {
    if (event is CheckingStatus) {
      yield* _mapCheckingStatusToState(event);
    } else if (event is DownloadFilePressed) {
      yield* _mapDownloadFilePressedToState(event);
    } else if (event is UploadFilePressed) {
      yield* _mapUploadFilePressedToState(event);
    } else if (event is ClassifyPressed) {
      yield* _mapClassifyPressedToState(event);
    } else if (event is DashboardPressed) {
      yield* _mapDashboardPressedToState(event);
    }
    else if (event is NewDataPressed) {
      yield* _mapNewDataPressedToState(event);
    }
  }

  Stream<ClassificationState> _mapDownloadFilePressedToState(
      DownloadFilePressed event) async* {
    yield CheckingStatusState(event.project, event.company);

    await launch(
        "https://firebasestorage.googleapis.com/v0/b/procurecentre.appspot.com/o/Test%2Fclassifier_template.xlsx?alt=media&token=27d0472e-d2c8-4aa1-be76-c2018297c590");

    Project updateProject =
        event.project.copyWith(classification: {'Stage': 2, "Completed" : false});
    await _projectRepository.updateProject(updateProject, event.company);
    print(updateProject.id);
    yield StatusCheckedState(updateProject, event.company, 2);
  }

  Stream<ClassificationState> _mapUploadFilePressedToState(
      UploadFilePressed event) async* {
    yield CheckingStatusState(event.project, event.company);
    print("before models");
    List<String> models = List.from(event.project.classification['Models']);

    // print(models);
    try {
      var response = await sendFile(event.selectedFile, event.fileName);
      if (response == '${event.fileName}.model') {
        models.add(event.fileName);
        Project updateProject = event.project
            .copyWith(classification: {'Stage': 3, 'Models': models, 'Completed' : false});
        await _projectRepository.updateProject(updateProject, event.company);
        print(updateProject.id);
        yield StatusCheckedState(updateProject, event.company, 3);
        print("Success");
      } else if (response == "Failure") {
        print('Please Check File!');
        yield StatusCheckedState(event.project, event.company, 2);
      } else {
        print("Network Error");
        yield StatusCheckedState(event.project, event.company, 2);
      }
    } catch (e) {
      yield StatusCheckedState(event.project, event.company, 2);
      print("Error");
    }
  }

  Stream<ClassificationState> _mapClassifyPressedToState(
      ClassifyPressed event) async* {
    yield CheckingStatusState(event.project, event.company);
  var myList = await getList(event.project, event.company);
   var predictList = await predictClass(myList, event.modelName, event.categories);

  List<DataPoint> dpList =
      await _extractionRepository.getData(event.project, event.company);

  for (int i = 0; i < predictList.length; i++) {
    print(dpList[i].id);
    print(dpList[i].supplier);
    DataPoint newDP = dpList[i].copyWith(category: predictList[i]);
    _extractionRepository.updateDataPoint(
        newDP, event.project, event.company);

  }
  var newList =
        await _extractionRepository.getData(event.project, event.company);
        var map = event.project.classification;
        map['Stage'] = 4;
        map['Completed'] = true;
        print(map);

        Project updateProject = event.project.copyWith(classification: map);
        await _projectRepository.updateProject(updateProject, event.company);
        yield StatusCheckedState(event.project, event.company, 4);

    //yield Stage4State(event.project, event.company);
  }

    Stream<ClassificationState> _mapNewDataPressedToState(
      NewDataPressed event) async* {
    Project updateProject =
        event.project.copyWith(classification: {'Stage': 1});
    await _projectRepository.updateProject(updateProject, event.company);
    print(updateProject.id);
    yield StatusCheckedState(updateProject, event.company, 1);
  }

  Stream<ClassificationState> _mapDashboardPressedToState(
      DashboardPressed event) async* {
    //yield Stage2State(event.project, event.company);
  }

  // Stream<ClassificationState>_mapClassificationCompleteToState(ClassificationComplete event) async* {
  //   yield ClassifiedState(event.project, event.data);
  // }

  // Stream<ClassificationState>_mapNotClassifiedToState(NotClassified event) async* {
  //   yield NotClassifiedState(event.project);
  // }

  // Stream<ClassificationState>_mapEnableClassificationToState(EnableClassification event) async* {
  //             bool enabled = event.project.classification['Enabled'];
  //   print(enabled);
  //    Project updateProject = event.project.copyWith(classification: {'Enabled' : !enabled, 'Completed' : false});
  //    //print(updateProject.classification);
  //         await _projectRepository.updateProject(updateProject, event.company);

  //   yield ClassifierEnabledState(updateProject, event.company);
  // }

  Stream<ClassificationState> _mapCheckingStatusToState(
      CheckingStatus event) async* {
    yield CheckingStatusState(event.project, event.company);
    int stage = event.project.classification['Stage'];
    yield StatusCheckedState(event.project, event.company, stage);
  }

  Future<List<String>> getList(Project project, String company) async {
  var dataPoints = await _extractionRepository.getData(project, company);
  List<String> result = [];
  for (int i = 0; i < dataPoints.length; i++) {
    String supplier = dataPoints[i].supplier;
    String description = dataPoints[i].description;
    String res = '$supplier $description';
    result.add(res);
  }
  print(result);
  return result;
}
}

//   // print(status);
//   // if (status) {
//   //   print(status);
//   //   List<DataPoint> data =
//   //       await _extractionRepository.getData(event.project, event.company);
//   //   yield Stage4State(event.project, event.company);
//   // } else {
//   //   yield Stage3State(event.project, event.company);

// }

//   Stream<ClassificationState>_mapCheckClassifierToState(CheckClassifier event) async* {
//   bool status = event.project.classification['Enabled'];
//   print(status);
//   if (status) {
//     // List<DataPoint> data =
//     //     await _extractionRepository.getData(event.project, event.company);
//     yield ClassifierEnabledState(event.project,event.company);
//   } else {
//     yield Stage1State(event.project, event.company);
//   }
// }

// Stream<ClassificationState>_mapClassificactionBeginToState(ClassificationBegin event) async* {
  // yield ClassifyingState();
  // var myList = await getList(event.project, event.company);
  // var predictList = await predictClass(myList);
  // List<DataPoint> dpList =
  //     await _extractionRepository.getData(event.project, event.company);
  // for (int i = 0; i < predictList.length; i++) {
  //   print(dpList[i].id);
  //   print(dpList[i].supplier);
  //   DataPoint newDP = dpList[i].copyWith(category: predictList[i]);
  //   _extractionRepository.updateDataPoint(
  //       newDP, event.project, event.company);

  // }
  // var newList =
  //       await _extractionRepository.getData(event.project, event.company);
  //       bool completed = event.project.classification['Completed'];
  //       print(completed);
  //       Project updateProject = event.project.copyWith(classification: {'Completed' : !completed});
  //       await _projectRepository.updateProject(updateProject, event.company);
  //       yield ClassifiedState(event.project, newList);

// }


