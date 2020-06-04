import 'package:ProcureCentre/dashboard/Widgets/insight_creator.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:flutter/material.dart';

class Insights extends StatefulWidget {
  final  List<DataPoint> data;
  Insights({this.data});
  @override
  _InsightsState createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
    List<DataPoint> get _data => widget.data;
  List<String> _insights;
  @override
  void initState() { 
    super.initState();
    String insightOne = createInsight(1, _data);
    // String insightTwo = createInsight(2, _data);
    String insightTwo = "There are 3 suppliers in the this project, each supplying all categories.";
    String insightThree = "In the Development category, Software Solutions is the most prominent supplier ";

    // String insightThree = createInsight(3, _data);
    // String insightThree = "Three";

    String insightFour = createInsight(4, _data);
    // String insightFour = "Four";

    String insightFive = createInsight(5, _data);
    // String insightFive = "Five";

    String insightSix = createInsight(6, _data);
    // String insightSix = "Six";

    _insights = [insightOne, insightTwo, insightThree, insightFour, insightFive, insightSix];

  }
  int insightNum = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .5,
        height: MediaQuery.of(context).size.height * .3,

        child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: <Widget>[
         Text("Insight ${insightNum +1}"),
         Row(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: [
     Visibility(
       visible: insightNum != 0,
                child: IconButton(icon: Icon(Icons.arrow_back,), onPressed: (){
         setState(() {
           insightNum = insightNum - 1;
         });
       },),
     ),
     Flexible(child: Container(child: Text(_insights[insightNum], overflow: TextOverflow.clip,))),
              Visibility(
       visible: insightNum != 5,
                child: IconButton(icon: Icon(Icons.arrow_forward,), onPressed: (){
         setState(() {
           insightNum = insightNum + 1;
         });
       },),
     ),
         ],)
       ]
        )

      );
  }
}