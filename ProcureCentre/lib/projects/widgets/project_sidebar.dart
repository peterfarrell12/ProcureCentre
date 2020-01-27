// import 'package:ProcureCentre/projects/bloc/current_project/bloc.dart';
// import 'package:ProcureCentre/projects/bloc/sidebar/bloc.dart';
// import 'package:ProcureCentre/projects/models/project.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProjectSidebar extends StatefulWidget {
//   ProjectSidebar();
//   @override
//   _ProjectSidebarState createState() => _ProjectSidebarState();
// }

// class _ProjectSidebarState extends State<ProjectSidebar> {
//   CurrentProjectBloc _currentProjectBloc;
//   SidebarBloc _sidebarBloc;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CurrentProjectBloc, CurrentProjectState>(
//       bloc: _currentProjectBloc,
//       builder: (context, state) {
//         if (state is CurrentProjectLoaded) {
//           return BlocBuilder<SidebarBloc, SidebarState>(
//             bloc: _sidebarBloc,
//             builder: (context, state){
//               if (state is ShowTimeline){
//                 return Container(
//             child: Text("This is The Timeline View")
//                 );}
//           else if (state is ShowDataExtraction) {
//           return Container (child: Text("This is The Data Extraction View"),);
//         } else if (state is ShowClassification) {
//                     return Container (child: Text("This is The Classification View"),);

//         }
//         else if (state is ShowDashboard) {
//                     return Container (child: Text("This is The Dashboard View"),);

//         }
//         else if (state is ShowTenderCreation) {
//                     return Container (child: Text("This is The Tender View"),);

//         }

//         else {
//           return Container(child: Text("This is The Timeline View"),);
//         }
//             },
//           );
//         }
//         else {
//           return Container(
//             child: Text("Please Choose A Project"),
//           );
//         }
//       },
//     );
//   }
// }