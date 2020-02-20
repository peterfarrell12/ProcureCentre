part of 'classification_bloc.dart';


abstract class ClassificationState extends Equatable {
  const ClassificationState();
}

class ClassificationInitial extends ClassificationState {
  @override
  List<Object> get props => [];
}

class StateLoading extends ClassificationState {
    List<Object> get props => [];
    @override
  String toString() => 'State Loading';


}

class ClassifiedState extends ClassificationState {
   final Project project;
   final List<DataPoint> data;


  const ClassifiedState(this.project, this.data);

  @override
  List<Object> get props => [project, data];

  @override
  String toString() => 'Classified { Project: ${project.name} }';
}

class ClassifyingState extends ClassificationState {

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Extracting';
}

class NotClassifiedState extends ClassificationState {
   final Project project;


  const NotClassifiedState(this.project);

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Not Classified { Project: ${project.name} }';
}
