import 'dart:html';

import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../project_repository.dart';



@immutable
abstract class ExtractionState extends Equatable {
  const ExtractionState();

  @override
  List<Object> get props => [];
}

class StateLoading extends ExtractionState {
    @override
  String toString() => 'State Loading';


}
class RetrieveFilesState extends ExtractionState {
  final Project project;
  final DateTime startTime;
  final DateTime endTime;

  const RetrieveFilesState({@required this.project, @required this.startTime, @required this.endTime});

  @override
  List<Object> get props => [project, startTime, endTime];

  @override
  String toString() => 'Retrieving Data... { Project :${project.name} }';
}

class FilesCheckedState extends ExtractionState {
  final List<DataPoint> items;

  const FilesCheckedState({@required this.items});

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Data Checked - Upload To FB}';
}


class ExtractingState extends ExtractionState {

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Extracting';
}

class CheckingFilesState extends ExtractionState {

}

class ExtractedState extends ExtractionState {
   final Project project;
   final List<DataPoint> data;


  const ExtractedState(this.project, this.data);

  @override
  List<Object> get props => [project, data];

  @override
  String toString() => 'Extracted { Project: ${project.name} }';
}

class NotExtractedState extends ExtractionState {
   final Project project;


  const NotExtractedState(this.project);

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Not Extracted { Project: ${project.name} }';
}


