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

  const ClassifyPressed( {@required this.project, @required this.company, @required this.modelName, @required this.categories,});

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
