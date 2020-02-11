import 'package:ProcureCentre/extraction/blocs/extraction_bloc/bloc.dart';
import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
import 'package:ProcureCentre/extraction/screens/extracted.dart';
import 'package:ProcureCentre/extraction/screens/extracting.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:ProcureCentre/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../simple_bloc_delegate.dart';

class ExtractionHomeScreen extends StatefulWidget {
  final Project project;
  final String company;
  ExtractionHomeScreen(
      {Key key, @required this.project, @required this.company})
      : super(key: key);

  _ExtractionHomeScreenState createState() => _ExtractionHomeScreenState();
}

class _ExtractionHomeScreenState extends State<ExtractionHomeScreen> {
  Project get _project => widget.project;
  String get _company => widget.company;

  ExtractionBloc _extractionBloc;

  //ExtractionRepository _extractionRepository = ExtractionRepository();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _extractionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _extractionBloc =
        ExtractionBloc(extractionRepository: FirebaseExtractionRepository());
    return BlocProvider<ExtractionBloc>(
        create: (context) => _extractionBloc,
        child: BlocBuilder<ExtractionBloc, ExtractionState>(
            bloc: _extractionBloc,
            builder: (context,state) {
              if (state is StateLoading) {
                return RaisedButton(
                    child: Text("Press"),
                    onPressed: () =>
                        _extractionBloc.add(CheckingStatus(project: _project)));
              }
              else if (state is ExtractedState) {
                return ExtractedScreen();
              }

              else if (state is NotExtractedState) {
                return ExtractingScreen(_project, _company);
              }

                            else if (state is ExtractingState) {
                return Container(child: CircularProgressIndicator(backgroundColor: Colors.purple));
              }

              else {
                return Text('Nope');
              }
            }
            // if(_project.extraction['Completed'] == true) {
            //   _extractionBloc.add(ExtractionComplete(project: _project));
            //   return ExtractedScreen();
            // }

            // else if (_project.extraction['Completed'] == false){
            //   _extractionBloc.add(ExtractionNotComplete(project: _project));
            //   return ExtractingScreen(_project, _company);
            // }
            ));
  }
}
