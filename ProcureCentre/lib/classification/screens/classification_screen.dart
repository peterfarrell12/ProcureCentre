import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
import 'package:ProcureCentre/classification/widgets/service.dart';
import 'package:ProcureCentre/extraction/extraction_repository.dart';
import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
import 'package:ProcureCentre/project_repository.dart';
import 'package:flutter/material.dart';
import 'dart:html';

//import 'dart:http';

class ClassificationScreen extends StatefulWidget {
  Project project;
  String company;

  ClassificationScreen({@required this.project,  @required this.company});

  @override
  _ClassificationScreenState createState() => _ClassificationScreenState();
}

class _ClassificationScreenState extends State<ClassificationScreen> {
      final ExtractionRepository _extractionRepository = FirebaseExtractionRepository();
      Project get _project => widget.project;
  String get _company => widget.company;

  ClassificationBloc _classificationBloc;

@override
  void dispose() {
    // TODO: implement dispose
    _classificationBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _classificationBloc = ClassificationBloc(extractionRepository: FirebaseExtractionRepository());
    return Material(
          child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
            Navigator.of(context).pop();
          },),
          title: Text("Classification Screen"),
        ),
        body: 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Classify!'),
                onPressed: () async{
                  var myList = await getList(_project, _company);
                 predictClass(myList);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> getList(Project project, String company) async {
    var dataPoints = await _extractionRepository.getData(project, company);
    List<String> result = [];
    for(int i = 0; i < dataPoints.length; i++) {
      String supplier = dataPoints[i].supplier;
      String description = dataPoints[i].description;
      String res = '$supplier $description';
      result.add(res);
    }
    print(result);
    return result;
  }
}
