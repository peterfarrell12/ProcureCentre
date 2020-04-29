import 'package:ProcureCentre/dashboard/Widgets/charts.dart';
import 'package:ProcureCentre/dashboard/helper/chart_functions.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ChartPageThree extends StatefulWidget {
   final Function pressLeft;
         final List<DataPoint> data;


    ChartPageThree({this.pressLeft, this.data});
  @override
  _ChartPageThreeState createState() => _ChartPageThreeState();
}

class _ChartPageThreeState extends State<ChartPageThree> {
      Function get _pressLeft => widget.pressLeft;
      List<DataPoint> get _data => widget.data;
  @override
  Widget build(BuildContext context) {
    
    return Container(
        child: Row(
      children: <Widget>[
             Container(
          width: MediaQuery.of(context).size.width * .05,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(FontAwesomeIcons.arrowLeft), onPressed: _pressLeft)
            ],
          ),
        ),
        Container(
                    width: MediaQuery.of(context).size.width * .75,
        child: _chartCard(PointsLineChart(createMonthlyData(_data), "Monthly Spend")),
        )
            ],
    ));
  }

  _chartCard(chart){
    return Tooltip(
      message: "Double Click To Focus!",
          child: GestureDetector(
        
        onDoubleTap: () => showDialog(context: context, 
        child:  AlertDialog(
            title: Text("Focus View"),
            content:Container(
          width: MediaQuery.of(context).size.width * .6,
          child: chart
          ),
        )),
            child: Container(
          width: MediaQuery.of(context).size.width *.7,
                height: MediaQuery.of(context).size.height *.7,

          child: Card(
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: chart
            )
            
          ),
        ),
      ),
    );
  }
}