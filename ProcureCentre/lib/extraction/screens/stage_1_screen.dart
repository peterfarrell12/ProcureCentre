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
import 'package:ProcureCentre/projects/bloc/projects/projects_bloc.dart';
import 'package:ProcureCentre/projects/bloc/projects/projects_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'stage_2_screen.dart';

class ExtractionScreenStage1Widget extends StatefulWidget {
  final Project project;
  final String company;

  const ExtractionScreenStage1Widget(
      {Key key, @required this.project, @required this.company})
      : super(key: key);
  @override
  _ExtractionScreenStage1WidgetState createState() =>
      _ExtractionScreenStage1WidgetState();
}

class _ExtractionScreenStage1WidgetState
    extends State<ExtractionScreenStage1Widget> {
  Project get _project => widget.project;
  String get _company => widget.company;
  List<String> _results;
  List<html.File> _files;
  bool filesPicked = false;
  int numFiles = 0;
    bool _chooseFile;
    List<int> _selectedFile;
  Uint8List _bytesData;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool failure = false;
  void onUploadFilesPressed(BuildContext context) async {
        BlocProvider.of<ExtractionBloc>(context)
        .add(UploadFilesPressed(project: _project, company: _company, rResult: _results, file: _files));
    // BlocProvider.of<ExtractionBloc>(context)
    //     .add(UploadFilesPressed(project: _project, company: _company));
  }

    void onChooseFilesPressed(BuildContext context) async {
    startWebFilePicker();

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
                        "Stage 1",
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
                Container(
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
                Container(
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
                  "Please Upload Invoices Below. Invoices Must Be In PDF Form",
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

              width: 134,
              height: 35,
              child: FlatButton(
                onPressed: () => this.onChooseFilesPressed(context),
                color: Color.fromARGB(0, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                textColor: Color.fromARGB(255, 109, 114, 120),
                padding: EdgeInsets.all(0),
                child: Text(
                  "Select Files",
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
            Visibility(
              visible: filesPicked,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  // width: 658,
                  // height: 402,
                  child: Column(
                    children: [
                      Container(
                        //width: 598,
                        margin: EdgeInsets.only(top: 45),
                        child: Text(
                          "$numFiles Files Chosen...Press Upload To Continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 109, 114, 120),
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 45),
                        child: RaisedButton(
                          onPressed: () => this.onUploadFilesPressed(context),
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
                            "Upload Files",
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
            ),
          ]),
        ),
      )
    ]));
  }
  //    _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //   }

  // }

  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      _files = uploadInput.files;
      //final file = files[0];
      Iterable<Future<String>> resultsFutures = _files.map((file) {
        final reader = html.FileReader();
        reader.readAsDataUrl(file);
        //reader.onError.listen((error) => completer.completeError(error));
        return reader.onLoad.first.then((_) => reader.result as String);
      });

      _results = await Future.wait(resultsFutures);
      //  BlocProvider.of<ExtractionBloc>(context).add(ExtractBegin(project: _project, company: _company,  rResult: results, file: files));
      //  _files.map((e) => BlocProvider.of<ProjectsBloc>(context).add(
      //                AddProjectFile(_project, _company, e)
      //               ));
      setState(() {
        numFiles = _files.length;
              filesPicked = true;

      });

      //r//eader.onLoadEnd.listen((e)   {
      //_handleResult(reader.result);
      //await sendFile(reader.result, file.name);

      //uploadToFirebase(file);
    });
  }
}
