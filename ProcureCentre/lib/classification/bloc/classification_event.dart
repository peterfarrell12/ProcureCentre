part of 'classification_bloc.dart';

abstract class ClassificationEvent extends Equatable {
  const ClassificationEvent();
}



class CheckingStatus extends ClassificationEvent {
  final Project project;
  final String company;

  const CheckingStatus({@required this.project, @required this.company});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Checking Status... { Project :${project.name} }';
}



class DownloadFilePressed extends ClassificationEvent {
  final Project project;
  final String company;

  const DownloadFilePressed({@required this.project, @required this.company});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Download File Pressed... { Project :${project.name} }';
}
class UploadFilePressed extends ClassificationEvent {
  final Project project;
  final String company;
  final String fileName;
  final List<int> selectedFile;


  const UploadFilePressed({@required this.project, @required this.company, @required this.fileName, @required this.selectedFile});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Upload File Pressed... { Project :$fileName }';
}

class ClassifyPressed extends ClassificationEvent {
  final Project project;
  final String company;
  final String modelName;
  final String categories;
  final bool selectAll;

  const ClassifyPressed( {@required this.project, @required this.company, @required this.modelName, @required this.categories,@required this.selectAll});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Classify Pressed... { Project :$modelName }';
}

class DashboardPressed extends ClassificationEvent {
  final Project project;
  final String company;
  final String modelName;

  const DashboardPressed({@required this.project, @required this.company, @required this.modelName});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Dashboard Pressed... { Project :${project.name} }';
}
class NewDataPressed extends ClassificationEvent {
  final Project project;
  final String company;

  const NewDataPressed({@required this.project, @required this.company});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'New Data Pressed... { Project :${project.name} }';
}
class Stage1Pressed extends ClassificationEvent {
  final Project project;
  final String company;

  const Stage1Pressed({@required this.project, @required this.company,});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Stage 1 Pressed... { Project :${project.name} }';
}

class Stage2Pressed extends ClassificationEvent {
  final Project project;
  final String company;

  const Stage2Pressed({@required this.project, @required this.company, });

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Stage 2 Pressed... { Project :${project.name} }';
}

class Stage3Pressed extends ClassificationEvent {
  final Project project;
  final String company;

  const Stage3Pressed({@required this.project, @required this.company,});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Stage 3 Pressed... { Project :${project.name} }';
}
class Stage4Pressed extends ClassificationEvent {
  final Project project;
  final String company;

  const Stage4Pressed({@required this.project, @required this.company,});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Stage 4 Pressed... { Project :${project.name} }';
}
