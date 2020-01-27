import 'package:flutter/material.dart';

class ClassificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.of(context).pop();
        },),
        title: Text("Classification Screen"),
      ),
    );
  }
}