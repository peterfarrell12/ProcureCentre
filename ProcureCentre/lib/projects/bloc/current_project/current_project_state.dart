import 'package:ProcureCentre/projects/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CurrentProjectState extends Equatable {
  const CurrentProjectState();
}

class InitialCurrentProjectState extends CurrentProjectState {
  @override
  List<Object> get props => [];
}

class CurrentProjectInitial extends CurrentProjectState {
  const CurrentProjectInitial();
  @override
  List<Object> get props => [];
}

class CurrentProjectLoading extends CurrentProjectState {
  const CurrentProjectLoading();
  @override
  List<Object> get props => [];
}

class CurrentProjectLoaded extends CurrentProjectState {
  final Project currentProject;
  const CurrentProjectLoaded(this.currentProject);
  @override
  List<Object> get props => [currentProject];
}

class CurrentProjectError extends CurrentProjectState {
  final String message;
  const CurrentProjectError(this.message);
  @override
  List<Object> get props => [message];
}

// class ShowDataExtraction extends CurrentProjectState {
//   final Project currentProject;
//   const ShowDataExtraction(this.currentProject);
//   @override
//   List<Object> get props => [currentProject];
// }
// class ShowClassification extends CurrentProjectState {
//   final Project currentProject;
//   const ShowClassification(this.currentProject);
//   @override
//   List<Object> get props => [currentProject];
// }
// class ShowDashboard extends CurrentProjectState {
//   final Project currentProject;
//   const ShowDashboard(this.currentProject);
//   @override
//   List<Object> get props => [currentProject];
// }
// class ShowTenderCreation extends CurrentProjectState {
//   final Project currentProject;
//   const ShowTenderCreation(this.currentProject);
//   @override
//   List<Object> get props => [currentProject];
// }