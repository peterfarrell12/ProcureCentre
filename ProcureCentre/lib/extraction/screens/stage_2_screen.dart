/*
*  Extraction_screen_stage1_widget.dart
*  ProcureCentre - Screens
*
*  Created by .
*  Copyright © 2018 . All rights reserved.
    */

import 'dart:html' as html;
import 'dart:typed_data';
import 'package:ProcureCentre/extraction/blocs/extraction_bloc/extraction_bloc.dart';
import 'package:ProcureCentre/extraction/blocs/extraction_bloc/extraction_event.dart';
import 'package:ProcureCentre/project_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';


class ExtractionScreenStage2Widget extends StatefulWidget {
  final Project project;
  final String company;

  const ExtractionScreenStage2Widget(
      {Key key, @required this.project, @required this.company})
      : super(key: key);
  @override
  _ExtractionScreenStage2WidgetState createState() =>
      _ExtractionScreenStage2WidgetState();
}

class _ExtractionScreenStage2WidgetState
    extends State<ExtractionScreenStage2Widget> {
  Project get _project => widget.project;
  String get _company => widget.company;



    void onExtractPressed(BuildContext context) async {
      DateTime sTime = DateTime.now().subtract(Duration(days: 2));
      BlocProvider.of<ExtractionBloc>(context)
        .add(ExtractDataPressed(project: _project, company: _company, startTime: sTime
, endTime: DateTime.now()));
  }

      void onCheckFilesPressed(BuildContext context) async {
        _launchURL("https://elis.rossum.ai/annotations/20383?page=1&pageSize=15&status=toReview,reviewing,importing,failedImport");
  }

    void onNewExtractPressed(BuildContext context) async {
    BlocProvider.of<ExtractionBloc>(context).add(NewExtractPressed(
        project: _project, company: _company));
  }

    void onStage3Pressed(BuildContext context) async {
    BlocProvider.of<ExtractionBloc>(context).add(Stage3Pressed(
        project: _project, company: _company));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        "Stage 2",
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
                  onTap: () => onStage3Pressed(context),
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
                          "Stage 3",
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
          width: 658,
          height: 402,
          child: Column(children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 598,
                margin: EdgeInsets.only(top: 46, right: 23),
                child: Text(
                  "Your Invoices Have Been Successfully Uploaded - Please Click The Below Link To Check Data",
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
                                      margin: EdgeInsets.only(top: 45),

              // width: 134,
              // height: 35,
              child: FlatButton(
                onPressed: () => this.onCheckFilesPressed(context),
                color: Color.fromARGB(0, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                textColor: Color.fromARGB(255, 109, 114, 120),
                padding: EdgeInsets.all(0),
                child: Text(
                  "Rossum Elis Platform Checker",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
            )
            ,
            Container(
                        margin: EdgeInsets.only(top: 45),
                        child: RaisedButton(
                          onPressed: () => this.onExtractPressed(context),
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
                            "Extract Data",
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
            
          ]),
        ),
      )
    ]));
  }
     _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
    }

  }
}
