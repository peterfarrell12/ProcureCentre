// import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
// import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
// import 'package:ProcureCentre/project_repository.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ClassificationMain extends StatefulWidget {
//   final Project project;
//   final String company;

//   const ClassificationMain(
//       {Key key, @required this.project, @required this.company})
//       : super(key: key);
//   @override
//   _ClassificationMainState createState() => _ClassificationMainState();
// }

// class _ClassificationMainState extends State<ClassificationMain> {
//   Project get _project => widget.project;
//   String get _company => widget.company;
//   ClassificationBloc _classificationBloc;
//   final PageController _pageController = PageController(
//     initialPage: 0,
//   );

//   @override
//   void dispose() {
//     _classificationBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     _classificationBloc = ClassificationBloc(
//       extractionRepository: FirebaseExtractionRepository(),
//       projectRepository: FirebaseProjectRepository(),
//     )..add(CheckingStatus(company: _company, project: _project));
//     return Material(
//         child: BlocBuilder<ClassificationBloc, ClassificationState>(
//             bloc: _classificationBloc,
//             builder: (context, state) {
//               if(state is Stage1State){
//                 print("nvfdsvdfv");
//                 _pageController.jumpToPage(0);
//               }
//                      else if(state is Stage2State){
//                 _pageController.jumpToPage(1);
//               }
//                         else if(state is Stage3State){
//                 _pageController.jumpToPage(0);
//               } else {
//                 print("Nothing");
//               }
//               return MaterialApp(
//                 home: Scaffold(
//                     body: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   child: SingleChildScrollView(
//                       child: Column(children: [
//                     Align(
//                         alignment: Alignment.topLeft,
//                         child: IconButton(
//                           onPressed: () => Navigator.pop(context),
//                           icon: Icon(
//                             Icons.arrow_back_ios,
//                             color: Color.fromARGB(255, 109, 114, 120),
//                           ),
//                         )),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: Container(
//                         child: Text(
//                           "Peters Company",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             //color: Color.fromARGB(255, 105, 182, 23),
//                             fontFamily: "Helvetica",
//                             fontWeight: FontWeight.w700,
//                             fontSize: 29,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                         child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     child: FittedBox(
//                                       fit: BoxFit.scaleDown,
//                                       child: Text(
//                                         "Spend Classification",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           color: Color.fromARGB(
//                                               255, 109, 114, 120),
//                                           fontFamily: "Helvetica",
//                                           fontWeight: FontWeight.w300,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     child: FittedBox(
//                                       fit: BoxFit.scaleDown,
//                                       child: Text(
//                                         "Peterf4282",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           color: Color.fromARGB(
//                                               255, 109, 114, 120),
//                                           fontFamily: "Helvetica",
//                                           fontWeight: FontWeight.w300,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]))),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: Container(
//                         width: 1147,
//                         margin: EdgeInsets.only(top: 111),
//                         child: Text(
//                           "We Use Machine Learning Algorithms To Automatically Classify All Spend Into Various Categories. In Order To Classify Data, We Need To First Train The Algorithms! Follow Below Instructions To Classify Your Data!",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Color.fromARGB(255, 109, 114, 120),
//                             fontFamily: "Helvetica",
//                             fontWeight: FontWeight.w300,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: Container(
//                         width: w * .5,
//                         height: 1,
//                         margin: EdgeInsets.only(top: 60),
//                         decoration: BoxDecoration(
//                           color: Color.fromARGB(255, 109, 114, 120),
//                         ),
//                         child: Container(),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Align(
//                         alignment: Alignment.topCenter,
//                         child: 
//                         Text("HI"),
//                         )
                            
//                       ),
                    
//                   ])),
//                 )),
//               );
//             }));
//   }


// }
