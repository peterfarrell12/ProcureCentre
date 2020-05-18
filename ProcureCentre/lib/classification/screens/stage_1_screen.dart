/*
*  classification_screen_stage1_widget.dart
*  ProcureCentre - Screens
*
*  Created by .
*  Copyright © 2018 . All rights reserved.
    */

import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
import 'package:ProcureCentre/project_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'stage_2_screen.dart';


class ClassificationScreenStage1Widget extends StatefulWidget {
  final Project project;
  final String company;

  const ClassificationScreenStage1Widget({Key key, @required this.project, @required this.company}) : super(key: key);
  @override
  _ClassificationScreenStage1WidgetState createState() => _ClassificationScreenStage1WidgetState();
}

class _ClassificationScreenStage1WidgetState extends State<ClassificationScreenStage1Widget> {

  Project get _project => widget.project;
  String get _company => widget.company;

  void onDownloadButtonPressed(BuildContext context)async  {
   BlocProvider.of<ClassificationBloc>(context).add(
                            DownloadFilePressed(
                                project: _project, company: _company));
  
  }

        void onStage2Pressed(BuildContext context) async {
    BlocProvider.of<ClassificationBloc>(context).add(Stage2Pressed(
        project: _project, company: _company));
  }

      void onStage3Pressed(BuildContext context) async {
    BlocProvider.of<ClassificationBloc>(context).add(Stage3Pressed(
        project: _project, company: _company,));
  }

        void onStage4Pressed(BuildContext context) async {
    BlocProvider.of<ClassificationBloc>(context).add(Stage4Pressed(
        project: _project, company: _company,));
  }

  @override
  Widget build(BuildContext context) {
  
    return  Container(
      child: Column(
        children: [
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
                  width: 658,
                  height: 402,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 598,
                          margin: EdgeInsets.only(top: 46, right: 23),
                          child: Text(
                            "Please Download Below Template And Populate With Data (Supplier, Description and The Category.  There must Be At Least 33 Examples Per Category",
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
                        child: RaisedButton(
                          onPressed: () =>
                         
                          this.onDownloadButtonPressed(context),
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
                            "Download File",
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
  //    _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //   }

  // }
}