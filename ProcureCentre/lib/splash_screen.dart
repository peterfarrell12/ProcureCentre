import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
                color: Colors.blue,
                  child: Center(child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 50, color: Colors.white),
              children: <TextSpan> [
                TextSpan(text: "Procure", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "Centre", style: TextStyle(fontStyle: FontStyle.italic))
              ]
            ),
          ),),)),
        ],
      ),
    );
  }
}
