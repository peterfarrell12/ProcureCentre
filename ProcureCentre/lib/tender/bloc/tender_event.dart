part of 'tender_bloc.dart';

abstract class TenderEvent extends Equatable {
  const TenderEvent();
}

class CheckingStatus extends TenderEvent {
  final Project project;
  final String company;

  const CheckingStatus({@required this.project, @required this.company});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Checking Status... { Project :${project.name} }';
}

class TenderBegin extends TenderEvent {
  final Project project;
  final String company;
  final Tender tender;

  const TenderBegin({@required this.project, @required this.company, @required this.tender});

  @override
  List<Object> get props => [project, company];

  @override
  String toString() => 'Tender Has Begun { Project :${project.name}, }';
}

class TenderCreated extends TenderEvent {
  final Project project;
  final String company;
  final List<Tender> tenders;

  const TenderCreated({@required this.project, @required this.company, @required this.tenders});

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Tender Has Begun { Project :${project.name},}';
}

class TenderChosen extends TenderEvent{
  final Tender tender;
  final Project project;

  TenderChosen(this.tender, this.project);

  @override
  List<Object> get props => [tender, project];

  @override
  String toString() => 'Tender Chosen { Project :${tender.projectName},}';

}

class TenderNotCreated extends TenderEvent {
  final Project project;
  final String company;


  const TenderNotCreated({@required this.project, @required this.company});

  @override
  List<Object> get props => [project, company];

  @override
  String toString() => 'Tender Not Completed { Project :${project.name},}';
}