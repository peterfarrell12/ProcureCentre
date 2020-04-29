// import 'dart:ui';

// import 'package:ProcureCentre/classification/screens/classification_main.dart';
// import 'package:ProcureCentre/classification/screens/classification_screen.dart';
// import 'package:ProcureCentre/extraction/blocs/extraction_bloc/bloc.dart';
// import 'package:ProcureCentre/extraction/models/extracted_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../project_repository.dart';
// import '../firebase_extraction_repository.dart';

// class ExtractedScreen extends StatefulWidget {
//   final List<DataPoint> projectData;
//   final Project project;
//   final String company;

//   ExtractedScreen(
//       {@required this.projectData,
//       @required this.project,
//       @required this.company});
//   @override
//   _ExtractedScreenState createState() => _ExtractedScreenState();
// }

// class _ExtractedScreenState extends State<ExtractedScreen> {
//   List<DataPoint> get _projectData => widget.projectData;
//   Project get _project => widget.project;
//   String get _company => widget.company;
//   List<DataPoint> selectedData;
//   bool sort;

//   onSortColumn(int columnIndex, bool ascending) {
//     if (columnIndex == 10) {
//       if (ascending) {
//         _projectData.sort((a, b) => a.total.compareTo(b.total));
//       } else {
//         _projectData.sort((a, b) => b.total.compareTo(a.total));
//       }
//     }
//   }

//   onSelectedRow(bool selected, DataPoint user) async {
//     setState(() {
//       if (selected) {
//         selectedData.add(user);
//       } else {
//         selectedData.remove(user);
//       }
//     });
//   }

//   //ExtractionBloc _extractionBloc;
//   @override
//   void initState() {
//     sort = false;
//     selectedData = [];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ExtractionBloc _extractionBloc =
//         BlocProvider.of<ExtractionBloc>(context);
//     //  _extractionBloc =
//     //     ExtractionBloc(extractionRepository: FirebaseExtractionRepository(), projectRepository: FirebaseProjectRepository());
//     return
//         // BlocProvider<ExtractionBloc>(
//         //         create: (context) => _extractionBloc,
//         //   //       child:
//         BlocBuilder<ExtractionBloc, ExtractionState>(
//             bloc: _extractionBloc,
//             builder: (context, state) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text("Spend Data Extraction Dashboard", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height * .2),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: <Widget>[
//                         RaisedButton(
//                           onPressed: () => _extractionBloc.add(AddDataPressed(
//                               project: _project, company: _company)),
//                           child: Text('Add More Data'),
//                         ),
//                         RaisedButton(
//                           onPressed: () {
//                             List<String> ids = [];
//                             for(int i = 0; i < selectedData.length; i++){
//                               ids.add(selectedData[i].id);
//                             }
//                             BlocProvider.of<ExtractionBloc>(context)
//                       .add(DeleteData(project: _project, company: _company, ids: ids));
//                           },
//                           child: Text('Delete Selected Data'),
//                         ),
//                         RaisedButton(
//                           onPressed: (){
//                             Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                   builder: (context) {
//                                     return ClassificationMain(project: _project, company: _company);
//                                   },
//                                 ),
//                               );
//                           },
//                           child: Text('Go To Classifier'),
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * .5,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                                               child: SingleChildScrollView(
//                                                 scrollDirection: Axis.vertical  ,
//                           padding: const EdgeInsets.all(8.0),
//                           child: DataTable(
//                               sortColumnIndex: 0,
//                               sortAscending: sort,
//                               showCheckboxColumn: false,
//                               columns: [
//                                 DataColumn(label: Text('Date')),
//                                 DataColumn(label: Text("Invoice")),
//                                 DataColumn(label: Text("Order")),
//                                 DataColumn(label: Text("Supplier")),
//                                 DataColumn(label: Text("Customer")),
//                                 DataColumn(label: Text("Code")),
//                                 DataColumn(label: Text("Description")),
//                                 DataColumn(label: Text("Qty"), numeric: true),
//                                 DataColumn(label: Text("UOM")),
//                                 DataColumn(label: Text("Price"), numeric: true),
//                                 DataColumn(
//                                     label: Text("Total"),
//                                     numeric: true,
//                                     onSort: (columnIndex, ascending) {
//                                       setState(() {
//                                         sort = !sort;
//                                       });
//                                       onSortColumn(columnIndex, ascending);
//                                     })
//                               ],
//                               rows: _projectData
//                                   .map((item) => DataRow(
//                                           selected: selectedData.contains(item),
//                                           onSelectChanged: (b) {
//                                             print("Onselect${item.price}");
//                                             onSelectedRow(b, item);
//                                           },
//                                           cells: [
//                                             DataCell(
//                                               Text(item.date),
//                                               onTap: () {
//                                                 print('Selected ${item.date}');
//                                               },
//                                             ),
//                                             DataCell(Text(item.invoice)),
//                                             DataCell(Text(item.order)),
//                                             DataCell(Text(item.supplier)),
//                                             DataCell(Text(item.customer)),
//                                             DataCell(Text(item.code)),
//                                             DataCell(Text(item.description)),
//                                             DataCell(Text(item.qty)),
//                                             DataCell(item.uom.length == 0 ? Text('Each'): Text(item.uom),),
//                                             DataCell(Text("€ ${double.parse(item.price).round()}", maxLines: 1,)),
//                                             DataCell(Text("€ ${double.parse(item.total).round()}", maxLines: 1,),),
//                                           ]))
//                                   .toList()),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             });
//     //);
//   }
// }
