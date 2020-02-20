import 'package:ProcureCentre/extraction/blocs/extraction_bloc/bloc.dart';
import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/extraction/screens/extracted.dart';
import 'package:ProcureCentre/extraction/screens/extracting.dart';
import 'package:ProcureCentre/projects/bloc/current_project/bloc.dart';
import 'package:ProcureCentre/projects/bloc/projects/bloc.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../project_repository.dart';


class ExtractionHomeScreen extends StatefulWidget {
  final Project project;
  final String company;
  ExtractionHomeScreen(
      {Key key, @required this.project, @required this.company,})
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

 Widget _checkFiles(Project project){
   DateTime sTime = DateTime.now().subtract(Duration(minutes: 10));
   return Center(
     child: Container(
          height: MediaQuery.of(context).size.height * .4,
                  width: MediaQuery.of(context).size.width * .3,
       child: Card(
         elevation: 5,
                child: AlertDialog(
              title: Text('Check Uploaded Files'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListBody(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Please Follow The Below Link To Check Your Files, When Happy Press Export Data!"),
                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new RichText(
                          text: new TextSpan(
                            children: [
                        
                              new TextSpan(
                                text: 'Rossum Elis Checker',
                                style: new TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () { launch('https://elis.rossum.ai/annotations/20383');
                                },
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
              actions: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        child: Text('Export'),
                        onPressed: () {
                          _extractionBloc.add(RetrieveFiles(startTime: sTime ,endTime: DateTime.now(), project: project));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
       ),
     ),
   );
    }
                  
 
  

  @override
  Widget build(BuildContext context) {
    _extractionBloc =
        ExtractionBloc(extractionRepository: FirebaseExtractionRepository(), projectRepository: FirebaseProjectRepository());
    return Material(
          child: Scaffold(
            appBar: AppBar(
        title: Text("Spend Data Extraction"),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.of(context).pop();},)
        
      ),
                      body: BlocProvider<ExtractionBloc>(
            create: (context) => _extractionBloc,
            child: BlocBuilder<ExtractionBloc, ExtractionState>(
                  bloc: _extractionBloc,
                  builder: (context, state) {
                    if (state is StateLoading) {
                      _extractionBloc.add(CheckingStatus(project: _project, company: _company));
                    } else if (state is ExtractedState) {
                      return ExtractedScreen(projectData: state.data, project: _project,);
                    } else if (state is NotExtractedState) {
                      return ExtractingScreen(_project, _company);
                      
                    } else if (state is FilesCheckedState) {
                      _extractionBloc.add(FilesChecked(company: _company, project: _project, data: state.items));
                    }


                    else if (state is CheckingFilesState) {
                      return _checkFiles(_project);
                        
                    }
                    else if (state is ExtractingState) {
                      return Center(
                        child: Container(
             height: MediaQuery.of(context).size.height * .4,
                    width: MediaQuery.of(context).size.width * .3,
            child: Card(
              elevation: 5,
                                      child: Center(
                                        child: Column(children: [
                                          CircularProgressIndicator(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "File Now Being Uploaded....",
                                            style: TextStyle(color: Colors.blue),
                                          )
                                        ]),
                                      ),
            ),
                        ),
                      );
                    } else {
                      return Text('Error');
                    }
                    return Container();
                  }
                  )
                  ),
          ),
    );
  }
}
