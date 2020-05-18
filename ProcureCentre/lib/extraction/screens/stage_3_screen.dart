/*
*  Extraction_screen_stage1_widget.dart
*  ProcureCentre - Screens
*
*  Created by .
*  Copyright © 2018 . All rights reserved.
    */

import 'dart:html' as html;
import 'dart:typed_data';
import 'package:ProcureCentre/classification/screens/test_class.dart';
import 'package:ProcureCentre/extraction/blocs/extraction_bloc/extraction_bloc.dart';
import 'package:ProcureCentre/extraction/blocs/extraction_bloc/extraction_event.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/extraction/widgets/export_to_csv.dart';
import 'package:ProcureCentre/project_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../firebase_extraction_repository.dart';

class ExtractionScreenStage3Widget extends StatefulWidget {
  final Project project;
  final String company;

  const ExtractionScreenStage3Widget({
    Key key,
    @required this.project,
    @required this.company,
  }) : super(key: key);
  @override
  _ExtractionScreenStage3WidgetState createState() =>
      _ExtractionScreenStage3WidgetState();
}

class _ExtractionScreenStage3WidgetState
    extends State<ExtractionScreenStage3Widget> {
  Project get _project => widget.project;
  String get _company => widget.company;
  List<DataPoint> _projectData = [];
  void _getData(Project project, String company) async {
    List<DataPoint> data =
        await FirebaseExtractionRepository().getData(project, company);
    setState(() {
      _projectData = data;
    });
  }

  void onNewExtractPressed(BuildContext context) async {
    BlocProvider.of<ExtractionBloc>(context).add(NewExtractPressed(
        project: _project, company: _company, ));
  }

    void onStage2Pressed(BuildContext context) async {
    BlocProvider.of<ExtractionBloc>(context).add(Stage2Pressed(
        project: _project, company: _company));
  }

  void onClassificationPressed(BuildContext context) {
    Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TestClass(project: _project, company: _company,);
                                    //ClassificationMain(project: state.currentProject, company: _company);
                                                                      },
                                                                    ),
                                                                  );
                                                                }
  

  List<DataPoint> selectedData;
  bool sort;

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 10) {
      if (ascending) {
        _projectData.sort((a, b) => a.total.compareTo(b.total));
      } else {
        _projectData.sort((a, b) => b.total.compareTo(a.total));
      }
    }
  }

  onSelectedRow(bool selected, DataPoint user) async {
    setState(() {
      if (selected) {
        selectedData.add(user);
      } else {
        selectedData.remove(user);
      }
    });
  }

  //ExtractionBloc _extractionBloc;
  @override
  void initState() {
    sort = false;
    selectedData = [];
    _getData(_project, _company);
    //_projectData = FirebaseExtractionRepository().getData(_project, _company);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _projectData.length == 0
        ? Align(
            alignment: Alignment.topCenter,
            child: Container(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator()))
        : Container(
            child: Column(children: [
            Align(
              alignment: Alignment.topCenter,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  margin: EdgeInsets.only(top: 51),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => onNewExtractPressed(context),
                                              child: Container(
                          width: 201,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 151, 151, 151),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Stage 1",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 109, 114, 120),
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
onTap: () => onStage2Pressed(context),
                                              child: Container(
                          width: 201,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 151, 151, 151),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Stage 2",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 109, 114, 120),
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 201,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,

                          //color: Color.fromARGB(255, 105, 182, 23),
                          border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 151, 151, 151),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Stage 3",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
                              Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              onPressed: () => onNewExtractPressed(context),
                              child: Text(
                                "New",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 109, 114, 120),
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                                                        RaisedButton(
                              onPressed: () => getCsv(_project, _projectData),
                              child: Text(
                                "Export",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 109, 114, 120),
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () => onClassificationPressed(context),
                              child: Text(
                                "Classifiy",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 109, 114, 120),
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ])),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                //height: double.infinity,
                child: Column(children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 598,
                      margin: EdgeInsets.only(top: 46, right: 23),
                      child: Text(
                        "Extracted Data Table",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 109, 114, 120),
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(8.0),
                        child: DataTable(
                            sortColumnIndex: 0,
                            sortAscending: sort,
                            showCheckboxColumn: false,
                            columns: [
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text("Invoice")),
                              DataColumn(label: Text("Order")),
                              DataColumn(label: Text("Supplier")),
                              DataColumn(label: Text("Customer")),
                              DataColumn(label: Text("Code")),
                              DataColumn(label: Text("Description")),
                              DataColumn(label: Text("Qty"), numeric: true),
                              DataColumn(label: Text("UOM")),
                              DataColumn(label: Text("Price"), numeric: true),
                              DataColumn(
                                  label: Text("Total"),
                                  numeric: true,
                                  onSort: (columnIndex, ascending) {
                                    setState(() {
                                      sort = !sort;
                                    });
                                    onSortColumn(columnIndex, ascending);
                                  })
                            ],
                            rows: _projectData
                                .map((item) => DataRow(
                                        selected: selectedData.contains(item),
                                        onSelectChanged: (b) {
                                          print("Onselect${item.price}");
                                          onSelectedRow(b, item);
                                        },
                                        cells: [
                                          DataCell(
                                            Text(item.date),
                                            onTap: () {
                                              print('Selected ${item.date}');
                                            },
                                          ),
                                          DataCell(Text(item.invoice)),
                                          DataCell(Text(item.order)),
                                          DataCell(Text(item.supplier)),
                                          DataCell(Text(item.customer)),
                                          DataCell(Text(item.code)),
                                          DataCell(Text(item.description)),
                                          DataCell(Text(item.qty)),
                                          DataCell(
                                            item.uom.length == 0
                                                ? Text('Each')
                                                : Text(item.uom),
                                          ),
                                          DataCell(Text(
                                            "€ ${item.price}",
                                            maxLines: 1,
                                          )),
                                          DataCell(
                                            Text(
                                              "€ ${item.total}",
                                              maxLines: 1,
                                            ),
                                          ),
                                        ]))
                                .toList()),
                      ),
                    ),
                  ),

                ]),
              ),
            )
          ]));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }
}
