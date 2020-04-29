import 'package:flutter/material.dart';

class LengthChoiceChip extends StatefulWidget {
  final List<int> reportList;
  final Function getLength;
  LengthChoiceChip(this.reportList, this.getLength);
  @override
  _LengthChoiceChipState createState() => _LengthChoiceChipState();
}

class _LengthChoiceChipState extends State<LengthChoiceChip> {
  String selectedChoice = "";
  // this function will build and return the choice list
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text("$item Days"),
          selected: selectedChoice == item.toString(),
          onSelected: (selected) {
            setState(() {
              selectedChoice = item.toString();
              widget.getLength(item);
            });
          },
          selectedColor: Colors.blue,
                labelStyle: TextStyle(
                  color: Colors.white, ),
                  backgroundColor: Colors.green,
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
