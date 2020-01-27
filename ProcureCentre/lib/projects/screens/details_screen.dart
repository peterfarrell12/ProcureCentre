import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen(this.id);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(id),
    );
  }
}