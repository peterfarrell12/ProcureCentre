import 'package:ProcureCentre/dashboard/Widgets/charts.dart';
import 'package:ProcureCentre/dashboard/helper/chart_functions.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChartPageTwo extends StatefulWidget {
    final Function pressLeft;
    final Function pressRight;
      final List<DataPoint> data;


    ChartPageTwo({this.pressLeft, this.pressRight, @required this.data});


  @override
  _ChartPageTwoState createState() => _ChartPageTwoState();
}

class _ChartPageTwoState extends State<ChartPageTwo> {
    Function get _pressLeft => widget.pressLeft;
      Function get _pressRight => widget.pressRight;
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

            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
               Container(child: _chartCard(BarChart(createSupplierData(_data), 'Top Suppliers'))),
               Container(child: _chartCard(CategoryPieChart(createCategoryData(_data), 'Spend By Category'))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
               Container(child: _chartCard(DonutAutoLabelChart(createLocationData(_data), 'Spend By Location'))),
               Container(child: _chartCard(HorizontalBarLabelChart(createItemData(_data), 'Top Items'))),
              ],
            ),
          ],
        )),
     
        // Container(
        //             width: MediaQuery.of(context).size.width * .75,

        //     child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: <Widget>[
        //         Container(child: SimpleBarChart()),
        //         Container(child: _infoCard()),
        //         Container(child: _infoCard()),
        //       ],
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: <Widget>[
        //         Container(child: _infoCard()),
        //         Container(child: _infoCard()),
        //         Container(child: _infoCard()),
        //       ],
        //     ),
        //   ],
        // )),
        Container(
          width: MediaQuery.of(context).size.width * .05,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(FontAwesomeIcons.arrowRight), onPressed: _pressRight)
            ],
          ),
        ),
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
          width: MediaQuery.of(context).size.width *.35,
                height: MediaQuery.of(context).size.height *.35,

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