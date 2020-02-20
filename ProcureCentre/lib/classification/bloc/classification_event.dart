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

class ClassificationBegin extends ClassificationEvent {
  final Project project;
  final String company;

  const ClassificationBegin({@required this.project, @required this.company});

  @override
  List<Object> get props => [project, company];

  @override
  String toString() => 'Classification Has Begun { Project :${project.name}, }';
}

class ClassificationComplete extends ClassificationEvent {
  final Project project;
  final List<DataPoint> data;

  const ClassificationComplete({@required this.project, @required this.data});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Classification Has Begun { Project :${project.name},}';
}

class NotClassified extends ClassificationEvent {
  final Project project;


  const NotClassified({@required this.project});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Classification Not Completed { Project :${project.name},}';
}
