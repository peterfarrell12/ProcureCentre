import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
import 'package:ProcureCentre/project_repository.dart';
import 'stage_1_screen.dart';
import 'stage_2_screen.dart';
import 'stage_3_screen.dart';
import 'stage_4_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestClass extends StatefulWidget {
  final Project project;
  final String company;

  const TestClass({Key key, this.project, this.company}) : super(key: key);
  @override
  _TestClassState createState() => _TestClassState();
}

class _TestClassState extends State<TestClass> {
  ClassificationBloc _classificationBloc;
  Project get _project => widget.project;
  String get _company => widget.company;

  @override
  void initState() {
    _classificationBloc = ClassificationBloc(
      extractionRepository: FirebaseExtractionRepository(),
      projectRepository: FirebaseProjectRepository(),
    );
    _classificationBloc
        .add(CheckingStatus(company: _company, project: _project));
    super.initState();
  }

  @override
  void dispose() {
    _classificationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          child: Column(children: [
        Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color.fromARGB(255, 109, 114, 120),
              ),
            )),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Text(
              "Spend Classification",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                //color: Color.fromARGB(255, 105, 182, 23),
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w700,
                fontSize: 29,
              ),
            ),
          ),
        ),
        Container(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Peter's Company",
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
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Peterf4282",
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
                    ]))),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 1147,
            margin: EdgeInsets.only(top: 111),
            child: Text(
              "We Use Machine Learning Algorithms To Automatically Classify All Spend Into Various Categories. In Order To Classify Data, We Need To First Train The Algorithms! Follow Below Instructions To Classify Your Data!",
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
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: w * .5,
            height: 1,
            margin: EdgeInsets.only(top: 60),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 109, 114, 120),
            ),
            child: Container(),
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                width: w * .8,
                height: h,
                child: BlocProvider<ClassificationBloc>(
                    create: (BuildContext context) => _classificationBloc,
                    child: Scaffold(
                      body:
                          BlocBuilder<ClassificationBloc, ClassificationState>(
                              bloc: _classificationBloc,
                              builder: (context, state) {
                                if (state is CheckingStatusState) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (state is StatusCheckedState) {
                                  print(state.stage);
                                  if (state.stage == 1) {
                                    return ClassificationScreenStage1Widget(
                                        project: state.project, company: _company);
                                  } 
                                  if (state.stage == 2) {
                                    return ClassificationScreenStage2Widget(
                                        project: state.project, company: _company);
                                  } 
                                  if (state.stage == 3) {
                                    return ClassificationScreenStage3Widget(
                                        project: state.project, company: _company);
                                  } 

                                  if (state.stage == 4) {
                                    return ClassificationScreenStage4Widget(
                                        project: state.project, company: _company);
                                  }
                                } else {
                                  return Container();
                                }
                              }),
                    )),
              ),
            ))
      ])),
    ));
  }
}
