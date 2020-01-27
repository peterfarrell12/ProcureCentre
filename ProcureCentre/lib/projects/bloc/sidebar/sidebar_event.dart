import 'package:ProcureCentre/projects/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class SidebarEvent extends Equatable {
  const SidebarEvent();
}

class GetTimeline extends SidebarEvent {
  final Project project;

  const GetTimeline(this.project);

  @override
  List<Object> get props => [project];

   @override
  String toString() => 'ShowTimeline { project: ${project.name}}';
}

class GetDataExtraction extends SidebarEvent {
  final Project project;

  const GetDataExtraction(this.project);

  @override
  List<Object> get props => [project];

   @override
  String toString() => 'GetDataExtraction { project: ${project.name}}';
}

class GetClassification extends SidebarEvent {
  final Project project;

  const GetClassification(this.project);

  @override
  List<Object> get props => [project];

   @override
  String toString() => 'GetClassification { project: ${project.name}}';
}

class GetDashboard extends SidebarEvent {
  final Project project;

  const GetDashboard(this.project);

  @override
  List<Object> get props => [project];

   @override
  String toString() => 'GetClassification { project: ${project.name}}';
}

class GetTenderCreation extends SidebarEvent {
  final Project project;

  const GetTenderCreation(this.project);

  @override
  List<Object> get props => [project];

   @override
  String toString() => 'GetTenderCreation { project: ${project.name}}';
}