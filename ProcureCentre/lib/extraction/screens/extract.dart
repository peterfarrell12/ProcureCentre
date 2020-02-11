import 'dart:html';

import 'package:flutter/material.dart';


class ExtractScreen extends StatefulWidget {
  final String fileName;
  final String fileURL;

  ExtractScreen(this.fileName, this.fileURL);
  @override
  _ExtractScreenState createState() => _ExtractScreenState();
}

class _ExtractScreenState extends State<ExtractScreen> {
  String get _file => widget.fileName;
  String get _fileURL => widget.fileURL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.of(context).pop();
        },),
      ),
          body: Column(
            children: <Widget>[
              Container(
        child: Text("This is where extracting happens - $_file"),
      ),
      RaisedButton(
        child: Text('Extract!'),
        onPressed: (){
          ;
        },
      )
            ],
          ),
    );
  }
}