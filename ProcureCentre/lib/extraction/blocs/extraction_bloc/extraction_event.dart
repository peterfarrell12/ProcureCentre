import 'dart:html';

import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ExtractionEvent extends Equatable {
  const ExtractionEvent();
}

class CheckingStatus extends ExtractionEvent {
  final Project project;
  final String company;

  const CheckingStatus({@required this.project, @required this.company});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Checking Status... { Project :${project.name} }';
}

class ExtractDataPressed extends ExtractionEvent {
  final Project project;
  final String company;
  final DateTime startTime;
  final DateTime endTime;

  const ExtractDataPressed(
      {@required this.project,
      @required this.company,
      @required this.startTime,
      @required this.endTime});

  @override
  List<Object> get props => [project, company, startTime, endTime];

  @override
  String toString() => 'Retrieving Data... { Project :${project.name} }';
}

class ClassificationPressed extends ExtractionEvent {
  final Project project;
  final String company;
  final List<DataPoint> data;

  const ClassificationPressed(
      {@required this.project, @required this.company, @required this.data});

  @override
  List<Object> get props => [project, company, data];

  @override
  String toString() => 'Upload To FB... { Project :${project.name} }';
}

class UploadFilesPressed extends ExtractionEvent {
  final Project project;
  final String company;

  final Object rResult;
  final List<File> file;

  const UploadFilesPressed(
      {@required this.project,
      @required this.company,
      //@required this.fileURL,
      @required this.rResult,
      @required this.file});

  @override
  List<Object> get props => [project, company, rResult, file];

  @override
  String toString() => 'Extraction Has Begun { Project :${project.name}, }';
}

class DeleteDataPressed extends ExtractionEvent {
  final Project project;
  final String company;
  final List<String> ids;

  const DeleteDataPressed(
      {@required this.project, @required this.company, @required this.ids});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Extraction Has Begun { Project :${project.name},}';
}

class NewExtractPressed extends ExtractionEvent {
  final Project project;
  final String company;

  const NewExtractPressed({@required this.project, @required this.company,});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Stage 1 Pressed... { Project :${project.name} }';
}

class GetDataEvent extends ExtractionEvent {
  final Project project;
  final String company;

  const GetDataEvent({@required this.project, @required this.company});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Get Data Event... { Project :${project.name} }';
}

class Stage2Pressed extends ExtractionEvent {
  final Project project;
  final String company;

  const Stage2Pressed({@required this.project, @required this.company, });

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Stage 2 Pressed... { Project :${project.name} }';
}

class Stage3Pressed extends ExtractionEvent {
  final Project project;
  final String company;

  const Stage3Pressed({@required this.project, @required this.company,});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Stage 3 Pressed... { Project :${project.name} }';
}