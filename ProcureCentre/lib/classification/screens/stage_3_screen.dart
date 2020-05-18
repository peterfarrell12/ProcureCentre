/*
*  classification_screen_stage3_widget.dart
*  ProcureCentre - Screens
*
*  Created by .
*  Copyright © 2018 . All rights reserved.
    */

import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassificationScreenStage3Widget extends StatefulWidget {
  final Project project;
  final String company;

  const ClassificationScreenStage3Widget({Key key, this.project, this.company})
      : super(key: key);
  @override
  _ClassificationScreenStage3WidgetState createState() =>
      _ClassificationScreenStage3WidgetState();
}

class _ClassificationScreenStage3WidgetState
    extends State<ClassificationScreenStage3Widget> {


  void onButtonPressed(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Would You Like To Classify: "),
          actions: <Widget>[
                        new FlatButton(
              child: new Text("All Data", style: TextStyle(color: Theme.of(context).primaryColor),),
              onPressed: () {
                    setState(() {
                      _selectAll = true;
                    });
                    Navigator.pop(context);
              },
            
            ),
            FlatButton(
              child: new Text("Just Unclassified Data", style: TextStyle(color: Theme.of(context).primaryColor),),
              onPressed: () {
                setState(() {
                  _selectAll = false;
                });
                                    Navigator.pop(context);

              },
            
            ),
          ],
        );
      },
    ).then((value) =>                     BlocProvider.of<ClassificationBloc>(context).add(ClassifyPressed(
        project: _project,
        company: _company,
        modelName: _selected,
        categories: _selected,
        selectAll: _selectAll)));

    

    

  }

  void onNewDataPressed(BuildContext context) {
    BlocProvider.of<ClassificationBloc>(context)
        .add(NewDataPressed(project: _project, company: _company));
  }

  void onStage1Pressed(BuildContext context) async {
    BlocProvider.of<ClassificationBloc>(context)
        .add(Stage1Pressed(project: _project, company: _company));
  }

  void onStage2Pressed(BuildContext context) async {
    BlocProvider.of<ClassificationBloc>(context).add(Stage2Pressed(
      project: _project,
      company: _company,
    ));
  }

  void onStage4Pressed(BuildContext context) async {
    BlocProvider.of<ClassificationBloc>(context).add(Stage4Pressed(
      project: _project,
      company: _company,
    ));
  }

    void _showSelectDialog() {

    
    }

  Project get _project => widget.project;
  String get _company => widget.company;
  String _selected = "";
  bool _selectAll = true;

  @override
  Widget build(BuildContext context) {
      List<String> models = List.from(_project.classification['Models']);
       print("Models :  $models");
    return SingleChildScrollView(
      child: Container(
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
                      onTap: () => onStage1Pressed(context),
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
                    GestureDetector(
                      onTap: () => onStage4Pressed(context),
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
                              "Stage 4",
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
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              // width: 658,
              // height: 402,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      width: 598,
                      margin: EdgeInsets.only(top: 46, right: 23),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Please Choose Classifer To Use",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 109, 114, 120),
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                          FlatButton(
                            onPressed: () => onNewDataPressed(context),
                            child: Text(
                              "Add New Model",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 109, 114, 120),
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: models.length,
                        itemBuilder: (context, position) {
                          return ListTile(
                            leading: Icon(
                              Icons.data_usage,
                              color: _selected == models[position]
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            title: Text(models[position]),
                            trailing: _selected == models[position]
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : Text(""),
                            onTap: () {
                              setState(() {
                                _selected = models[position];
                              });
                            },
                            selected: _selected == models[position],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.only(top: 45),
                    child: RaisedButton(
                      onPressed: () => this.onButtonPressed(context),
                      color: Theme.of(context).primaryColor,

                      //color: Color.fromARGB(255, 105, 182, 23),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color.fromARGB(255, 151, 151, 151),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      textColor: Color.fromARGB(255, 255, 255, 255),
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Classify",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// Align(
//   alignment: Alignment.topCenter,
//   child: Container(
//     width: 658,
//     height: 427,
//     child: Column(
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 7),
//           child: Text(
//             "Please Choose Classifier To Use",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Color.fromARGB(255, 109, 114, 120),
//               fontFamily: "Helvetica",
//               fontWeight: FontWeight.w300,
//               fontSize: 29,
//             ),
//           ),
//         ),
//         Spacer(),
//         //             Container(
//         //               child: ListView.builder(
//         //   itemCount: 3,
//         //   itemBuilder: (context, index) => item(),
//         // ),
//         //             ),
//         Container(
//           width: 519,
//           height: 73,
//           margin: EdgeInsets.only(bottom: 90),
//           child: FlatButton(
//             onPressed: () =>
//                 this.onButtonPressed(context),
//             color: Theme.of(context).primaryColor,
//             shape: RoundedRectangleBorder(
//               side: BorderSide(
//                 color:
//                     Color.fromARGB(255, 151, 151, 151),
//                 width: 1,
//                 style: BorderStyle.solid,
//               ),
//               borderRadius:
//                   BorderRadius.all(Radius.circular(30)),
//             ),
//             textColor:
//                 Color.fromARGB(255, 255, 255, 255),
//             padding: EdgeInsets.all(0),
//             child: Text(
//               "Classify",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color:
//                     Color.fromARGB(255, 255, 255, 255),
//                 fontFamily: "Helvetica",
//                 fontWeight: FontWeight.w300,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
