import 'dart:html';

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
// class FileChosenState extends ExtractionState {
//   final Project project;
//   final String fileName;
//   final String fileURL;

//   const FileChosenState(this.project, this.fileName, this.fileURL);
//   @override
//   List<Object> get props => [project, fileName, fileURL];

//   @override
//   String toString() => 'File Chosen { Project: ${project.name}, File: $fileName }';
// }


class ExtractingState extends ExtractionState {
  //  final Project project;
  //  final String fileName;
  //  final String fileURL;
  //  final Object rResult;
  //  final File file;


 // const ExtractingState(this.project, this.fileName, this.fileURL,this.rResult, this.file);



  @override
  List<Object> get props => [];

  @override
  String toString() => 'Extracting';
}

class ExtractedState extends ExtractionState {
   final Project project;


  const ExtractedState(this.project);

  @override
  List<Object> get props => [project];

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


