part of 'classification_bloc.dart';


abstract class ClassificationState extends Equatable {
  const ClassificationState();
}

// class ClassificationInitial extends ClassificationState {
//   @override
//   List<Object> get props => [];
// }

class StateLoading extends ClassificationState {
    List<Object> get props => [];
    @override
  String toString() => 'State Loading';

}

class CheckingStatusState extends ClassificationState {
   final Project project;
   final String company;


  const CheckingStatusState(this.project, this.company);

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Not Classified { Project: ${project.name} }';
}

class StatusCheckedState extends ClassificationState {
   final Project project;
   final String company;
   final int stage;


  const StatusCheckedState(this.project, this.company, this.stage);

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'Not Classified { Project: ${project.name} }';
}

// class Stage1State extends ClassificationState {
//    final Project project;
//    final String company;


//   const Stage1State(this.project, this.company);

//   @override
//   List<Object> get props => [project];

//   @override
//   String toString() => 'Not Classified { Project: ${project.name} }';
// }
// class Stage2State extends ClassificationState {
//    final Project project;
//    final String company;


//   const Stage2State(this.project, this.company);

//   @override
//   List<Object> get props => [project];

//   @override
//   String toString() => 'Not Classified { Project: ${project.name} }';
// }
// class Stage2ErrorState extends ClassificationState {
//    final Project project;
//    final String company;


//   const Stage2ErrorState(this.project, this.company);

//   @override
//   List<Object> get props => [project];

//   @override
//   String toString() => 'Not Classified { Project: ${project.name} }';
// }
// class Stage3State extends ClassificationState {
//    final Project project;
//    final String company;


//   const Stage3State(this.project, this.company);

//   @override
//   List<Object> get props => [project];

//   @override
//   String toString() => 'Not Classified { Project: ${project.name} }';
// }
// class Stage4State extends ClassificationState {
//    final Project project;
//    final String company;


//   const Stage4State(this.project, this.company);

//   @override
//   List<Object> get props => [project];

//   @override
//   String toString() => 'Not Classified { Project: ${project.name} }';
// }

