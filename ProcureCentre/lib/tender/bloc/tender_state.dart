part of 'tender_bloc.dart';

abstract class TenderState extends Equatable {
  const TenderState();
}

class StateLoading extends TenderState {
    List<Object> get props => [];
    @override
  String toString() => 'State Loading';


}

class TenderCreatedState extends TenderState {
   final Project project;
   final String company;
   final List<Tender> tenders;


  const TenderCreatedState(this.project, this.company, this.tenders);

  @override
  List<Object> get props => [project, company, tenders];

  @override
  String toString() => 'TenderCreated { Project: ${project.name} }';
}

class CreatingTenderState extends TenderState {

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Creating';
}

class ViewingTenderState extends TenderState {
  final Tender tender;
  final List<DataPoint> data;

  ViewingTenderState(this.tender, this.data);

  @override
  List<Object> get props => [tender, data];

  @override
  String toString() => 'Viewing Tender ${tender.projectName}';
}

class TenderNotCreatedState extends TenderState {
   final Project project;
   final String company;


  const TenderNotCreatedState(this.project, this.company);

  @override
  List<Object> get props => [project, company];

  @override
  String toString() => 'Not Tender Created { Project: ${project.name} }';
} 

class ExportingTenderState extends TenderState {
    @override
  List<Object> get props => [];


  String toString() => 'Exporting tender.......';
}

