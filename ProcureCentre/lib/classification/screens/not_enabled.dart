import 'dart:convert';
import 'dart:typed_data';

import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
import 'package:ProcureCentre/classification/widgets/service.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class NotEnabledScreen extends StatefulWidget {
  final Project project;
  final String company;

  NotEnabledScreen({@required this.project, @required this.company});

  @override
  _NotEnabledScreenState createState() => _NotEnabledScreenState();
}

class _NotEnabledScreenState extends State<NotEnabledScreen> {
  Project get _project => widget.project;
  String get _company => widget.company;
  ClassificationBloc _classificationBloc;
  bool checking = false;
  bool fileUploaded = false;
  bool fileSent = false;
  String fileName = '';
  List<int> _selectedFile;
  Uint8List _bytesData;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: BlocBuilder<ClassificationBloc, ClassificationState>(
      bloc: _classificationBloc,
      builder: (context, state) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text("Download File"),
                ),
                Container(
                    child: FlatButton(
                        child: Text(
                          "Classifier Template",
                          style: TextStyle(color: Colors.green),
                        ),
                        onPressed: () {
                          print("Launching URL");
                          _launchURL(
                              "https://firebasestorage.googleapis.com/v0/b/procurecentre.appspot.com/o/Test%2Fclassifier_template.xlsx?alt=media&token=27d0472e-d2c8-4aa1-be76-c2018297c590");
                        })),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: FlatButton(
                        child: Text("Reupload File"),
                        onPressed: () => startWebFilePicker())),
                Visibility(visible: fileUploaded, child: Text(fileName)),
              ],
            ),
            Visibility(
              visible: fileUploaded,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      child: Text("Enable"),
                      onPressed: () async {
                        var response = await sendFile(_selectedFile, fileName);
                        if (response == '$fileName.model') {
                          print("Success");
                        } else if (response == "Failure") {
                          print('Please Check File!');
                        } else {
                          print("Network Error");
                        }
                        // BlocProvider.of<ClassificationBloc>(context).add(
                        //     EnableClassification(
                        //         project: _project, company: _company)
                        //         );
                      }),
                ],
              )),
            ),
          ],
        ));
      },
    ));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
          checking = false;
          fileName = file.name;

          fileUploaded = true;
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
