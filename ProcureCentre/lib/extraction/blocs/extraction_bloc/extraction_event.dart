
import 'dart:html';

import 'package:ProcureCentre/projects/models/project.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ExtractionEvent extends Equatable {
  const ExtractionEvent();
}

class AddDataPressed extends ExtractionEvent {
  final Project project;

  const AddDataPressed({@required this.project});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Add Data Pressed { Project :${project.name} }';
}

class CheckingStatus extends ExtractionEvent {
  final Project project;

  const CheckingStatus({@required this.project});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Checking Status... { Project :${project.name} }';
}

class ExtractBegin extends ExtractionEvent {
  final Project project;
  final String company;
   final String fileName;
   //final String fileURL;
   final Object rResult;
   final File file;

  const ExtractBegin({@required this.project, @required this.company, @required this.fileName, 
  //@required this.fileURL, 
  @required this.rResult,@required this.file});

  @override
  List<Object> get props => [project, company, fileName, rResult, file];

  @override
  String toString() => 'Extraction Has Begun { Project :${project.name}, File $fileName }';
}

class ExtractComplete extends ExtractionEvent {
  final Project project;


  const ExtractComplete({@required this.project});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Extraction Has Begun { Project :${project.name},}';
}

class NotExtracted extends ExtractionEvent {
  final Project project;


  const NotExtracted({@required this.project});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Extraction Not Completed { Project :${project.name},}';
}

class DeleteData extends ExtractionEvent {

  final Project project;

  const DeleteData({@required this.project});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Extraction Has Begun { Project :${project.name},}';
}


// class FileUploaded extends ExtractionEvent {
//   final Project project;
//   final File file;
//   final String company;
  

//   const FileUploaded({@required this.project,@required this.company, @required this.file});

//   @override
//   List<Object> get props => [project];

//   @override
//   String toString() => 'Upload File Pressed { Project :${project.name} }';
//}
