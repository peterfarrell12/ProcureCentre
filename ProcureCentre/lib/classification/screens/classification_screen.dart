// import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
// import 'package:ProcureCentre/classification/screens/not_enabled.dart';
// import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
// import 'package:ProcureCentre/project_repository.dart';
// import 'package:ProcureCentre/tender/stage_1_screen.dart';
// import 'package:ProcureCentre/tender/stage_2_screen.dart';
// import 'package:ProcureCentre/tender/stage_3_screen.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'classified.dart';
// import 'not_classified.dart';

// //import 'dart:http';

// class ClassificationScreen extends StatefulWidget {
//   final Project project;
//   final String company;

//   ClassificationScreen({
//     Key key,
//     @required this.project,
//     @required this.company,
//   }) : super(key: key);
//   @override
//   _ClassificationScreenState createState() => _ClassificationScreenState();
// }

// class _ClassificationScreenState extends State<ClassificationScreen> {
//   Project get _project => widget.project;
//   String get _company => widget.company;

//   ClassificationBloc _classificationBloc;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _classificationBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _classificationBloc = ClassificationBloc(
//         extractionRepository: FirebaseExtractionRepository(),
//         projectRepository: FirebaseProjectRepository());
//     return Material(
//       child: Scaffold(
//           appBar: AppBar(
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             title: Text("Classification Screen"),
//           ),
//           body: BlocProvider<ClassificationBloc>(
//             create: (context) => _classificationBloc,
//             child: BlocBuilder<ClassificationBloc, ClassificationState>(
//               bloc: _classificationBloc,
//               builder: (context, state) {
//                 if (state is StateLoading) //classifier_enabled?
//                 {
//                   // _classificationBloc.add(
//                   //     CheckClassifier(project: _project, company: _company));
//                 } else if (state is ClassifierEnabledState) {
//                   _classificationBloc.add(
//                       CheckingStatus(project: _project, company: _company));
//                 }

//                 else if (state is Stage1State){
//                   return ClassificationScreenStage1Widget();
//                 }
//                                 else if (state is Stage2State){
//                   return ClassificationScreenStage2Widget();
//                 }
//                                 else if (state is Stage3State){
//                   return ClassificationScreenStage3Widget();
//                 }
//                 //             else if (state is Stage4State){
//                 //   return ClassificationScreenStage4Widget();
//                 // }
//                 // } else if (state is ClassifierNotEnabledState) {
//                 //   return Container(
//                 //       child: NotEnabledScreen(
//                 //           project: _project, company: _company));
//                 // } else if (state is ClassifiedState) {
//                 //   return ClassifiedScreen(
//                 //     projectData: state.data,
//                 //     project: _project,
//                 //   );
//                 // } else if (state is NotClassifiedState) {
//                 //   print(_project.name);
//                 //   return NotClassifiedScreen(
//                 //     project: _project,
//                 //     company: _company,
//                 //   );
//                 // } else if (state is ClassifyingState) {
//                 //   return Center(child: CircularProgressIndicator());
//                 // } else {
//                 //   return Text('Error');
//                 // }
//                 return Container();
//               }
//             ),
//           )
//           // Center(
//           //   child: Column(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     crossAxisAlignment: CrossAxisAlignment.center,
//           //     children: <Widget>[
//           //       RaisedButton(
//           //         child: Text('Classify!'),
//           //         onPressed: () async{
//           //           var myList = await getList(_project, _company);
//           //          predictClass(myList);
//           //         },
//           //       )
//           //     ],
//           //   ),
//           // ),
//           ),
//     );
//   }
// }
