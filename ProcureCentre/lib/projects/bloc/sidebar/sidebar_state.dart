import 'package:ProcureCentre/projects/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class SidebarState extends Equatable {
  const SidebarState();
}

class InitialSidebarState extends SidebarState {
  @override
  List<Object> get props => [];
}

class ShowTimeline extends SidebarState {
  final Project currentProject;
  const ShowTimeline(this.currentProject);
  @override
  List<Object> get props => [currentProject];
}

class ShowDataExtraction extends SidebarState {
  final Project currentProject;
  const ShowDataExtraction(this.currentProject);
  @override
  List<Object> get props => [currentProject];
}
class ShowClassification extends SidebarState {
  final Project currentProject;
  const ShowClassification(this.currentProject);
  @override
  List<Object> get props => [currentProject];
}
class ShowDashboard extends SidebarState {
  final Project currentProject;
  const ShowDashboard(this.currentProject);
  @override
  List<Object> get props => [currentProject];
}
class ShowTenderCreation extends SidebarState {
  final Project currentProject;
  const ShowTenderCreation(this.currentProject);
  @override
  List<Object> get props => [currentProject];
}