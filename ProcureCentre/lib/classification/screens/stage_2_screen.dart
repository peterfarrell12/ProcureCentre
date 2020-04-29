/*
*  classification_screen_stage2_widget.dart
*  ProcureCentre - Screens
*
*  Created by .
*  Copyright © 2018 . All rights reserved.
    */

import 'dart:convert';
import 'dart:typed_data';

import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'stage_3_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:html' as html;


class ClassificationScreenStage2Widget extends StatefulWidget {
  final Project project;
  final String company;

  const ClassificationScreenStage2Widget({Key key, this.project, this.company})
      : super(key: key);
  @override
  _ClassificationScreenStage2WidgetState createState() =>
      _ClassificationScreenStage2WidgetState();
}

class _ClassificationScreenStage2WidgetState
    extends State<ClassificationScreenStage2Widget> {
  Project get _project => widget.project;
  String get _company => widget.company;
  String fileName = '';
   List<int> _selectedFile;
  Uint8List _bytesData;
  void onUploadButtonPressed(BuildContext context) {
   BlocProvider.of<ClassificationBloc>(context).add(
                            UploadFilePressed(
                                project: _project, company: _company, selectedFile: _selectedFile, fileName: fileName));
  }

  void onSelectFilePressed(BuildContext context) {
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
                  GestureDetector(
                    onTap: () => _goBack(),
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
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    "Please Re-Upload The Populated File Below",
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
                  width: 360,
                  height: 93,
                  margin: EdgeInsets.only(top: 43),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 134,
                          height: 35,
                          child: FlatButton(
                            onPressed: () => this.onSelectFilePressed(context),
                            color: Color.fromARGB(0, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                            ),
                            textColor: Color.fromARGB(255, 109, 114, 120),
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Select File",
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
                      ),
                      Spacer(),
                      Container(
                        height: 37,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 151, 151, 151),
                          ),
                        ),
                        child: Container(
                          child: Text(
                            fileName
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(bottom: 90),
                  child: RaisedButton(
                    onPressed: () => this.onUploadButtonPressed(context),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color.fromARGB(255, 151, 151, 151),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    textColor: Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Upload File",
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
    );
  }

  _goBack() {
    // BlocProvider.of<ClassificationBloc>(context)
    //     .add(CheckClassifier(project: _project, company: _company));
  }

  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);
        setState(() {
          fileName = file.name;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    print("Handling Result");
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }
}
