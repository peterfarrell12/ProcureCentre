import 'package:ProcureCentre/projects/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class CurrentProjectEvent extends Equatable {
  const CurrentProjectEvent();
}

class GetCurrentProject extends CurrentProjectEvent {
  final Project project;

  const GetCurrentProject(this.project);

  @override
  List<Object> get props => [project];

   @override
  String toString() => 'getCurrentProject { project: ${project.name}}';
}

// class ShowTimeline extends CurrentProjectEvent {
//   final Project project;

//   const ShowTimeline(this.project);

//   @override
//   List<Object> get props => [project];

//    @override
//   String toString() => 'ShowTimeline { project: ${project.name}}';
// }

// class GetDataExtraction extends CurrentProjectEvent {
//   final Project project;

//   const GetDataExtraction(this.project);

//   @override
//   List<Object> get props => [project];

//    @override
//   String toString() => 'GetDataExtraction { project: ${project.name}}';
// }

// class GetClassification extends CurrentProjectEvent {
//   final Project project;

//   const GetClassification(this.project);

//   @override
//   List<Object> get props => [project];

//    @override
//   String toString() => 'GetClassification { project: ${project.name}}';
// }

// class GetDashboard extends CurrentProjectEvent {
//   final Project project;

//   const GetDashboard(this.project);

//   @override
//   List<Object> get props => [project];

//    @override
//   String toString() => 'GetClassification { project: ${project.name}}';
// }

// class GetTenderCreation extends CurrentProjectEvent {
//   final Project project;

//   const GetTenderCreation(this.project);

//   @override
//   List<Object> get props => [project];

//    @override
//   String toString() => 'GetTenderCreation { project: ${project.name}}';
// }