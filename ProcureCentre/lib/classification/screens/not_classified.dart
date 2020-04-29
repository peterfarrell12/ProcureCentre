import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotClassifiedScreen extends StatefulWidget {
  final Project project;
  final String company;

  NotClassifiedScreen({@required this.project, @required this.company});

  @override
  _NotClassifiedScreenState createState() => _NotClassifiedScreenState();
}

class _NotClassifiedScreenState extends State<NotClassifiedScreen> {
  Project get _project => widget.project;
  String get _company => widget.company;
  ClassificationBloc _classificationBloc;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: BlocBuilder<ClassificationBloc, ClassificationState>(
      bloc: _classificationBloc,
      builder: (context, state) {
        return Center(
            child: Container(
                child: FlatButton(
                  child: Text("Classify"),
                    onPressed: (){} )));
                        // BlocProvider.of<ClassificationBloc>(context).add(
                        //     ClassificationBegin(
                        //         project: _project, company: _company)))));
      },
    ));
  }
}
