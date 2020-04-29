import 'package:ProcureCentre/extraction/blocs/extraction_bloc/bloc.dart';
import 'package:ProcureCentre/extraction/blocs/extraction_bloc/extraction_bloc.dart';
import 'package:ProcureCentre/extraction/blocs/extraction_bloc/extraction_state.dart';
import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/project_repository.dart';
import 'stage_1_screen.dart';
import 'stage_2_screen.dart';
import 'stage_3_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtractionMain extends StatefulWidget {
  final Project project;
  final String company;

  const ExtractionMain({Key key, this.project, this.company}) : super(key: key);
  @override
  _ExtractionMainState createState() => _ExtractionMainState();
}

class _ExtractionMainState extends State<ExtractionMain> {
  ExtractionBloc _extractionBloc;
  Project get _project => widget.project;
  String get _company => widget.company;

  @override
  void initState() {
    _extractionBloc = ExtractionBloc(
      extractionRepository: FirebaseExtractionRepository(),
      projectRepository: FirebaseProjectRepository(),
    );
    _extractionBloc.add(CheckingStatus(project: _project, company: _company));
    super.initState();
  }

  @override
  void dispose() {
    _extractionBloc.close();
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
              "Data Extraction",
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
                          child: Text(_company,
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
                            _project.user,
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
              "We Use A Third Party Software Called Rossum Elis To Automatically Extract All Data From Any Invoice. There Are Four Steps Involved",
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
                height: h * 2,
                child: BlocProvider<ExtractionBloc>(
                    create: (BuildContext context) => _extractionBloc,
                    child: Scaffold(
                      body: BlocBuilder<ExtractionBloc, ExtractionState>(
                          bloc: _extractionBloc,
                          builder: (context, state) {
                            if (state is CheckingStatusState) {
                              return Container(child: CircularProgressIndicator());
                            }
                            if (state is StatusCheckedState) {
                              print(state.stage);
                              if (state.stage == 1) {
                                return ExtractionScreenStage1Widget(
                                    project: _project, company: _company);
                              }
                              if (state.stage == 2) {
                                return ExtractionScreenStage2Widget(
                                    project: _project, company: _company);
                              }
                              if (state.stage == 3) {
                                return ExtractionScreenStage3Widget(
                                    project: _project, company: _company);
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
