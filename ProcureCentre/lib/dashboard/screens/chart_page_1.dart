import 'package:ProcureCentre/dashboard/helper/data_transformer.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChartPageOne extends StatefulWidget {
  final Function press;
  final List<DataPoint> data;

  ChartPageOne({@required this.press, @required this.data});
  @override
  _ChartPageOneState createState() => _ChartPageOneState();
}

class _ChartPageOneState extends State<ChartPageOne> {
  Function get _press => widget.press;
  List<DataPoint> get _data => widget.data;

  var  spend;
  var suppliers;
  var categories;

 
  @override
  Widget build(BuildContext context) {
    return Container(
        child: _data.isEmpty ? Center(child: Container(child: Text('There is no data to analyze yet!'),)):Row(
      children: <Widget>[
        
        Container(
                    width: MediaQuery.of(context).size.width * .8,

            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

           
                Container(child: _infoCard("Spend","€${totalSpend(_data).toString()}", "The Total Spend of All Invoices")),
                Container(child: _infoCard("Suppliers",  "${totalSuppliers(_data).toString()}", 'The Total Number of Supplier')),
                Container(child: _infoCard("Categories", totalCategories(_data).toString(), 'The Total Number of Categories')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                 Container(child: _infoCard("Top Supplier", topSupplierspend(_data), topSupplierspend(_data))),
                 Container(child: _infoCard("Top Item", topItemSpend(_data), topItemSpend(_data))),
                Container(child: _infoCard("Avg / Invoice", "€${avgPerInvoice(_data).toString()}", "The Average Spend on All Invoices")),
              ],
            ),
          ],
        )),
        Container(
          width: MediaQuery.of(context).size.width * .05,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(FontAwesomeIcons.arrowRight), onPressed: _press)
            ],
          ),
        ),
      ],
    ));
  }

  Widget _infoCard(String text, String main, String toolTip) {
    return Container(
      width: MediaQuery.of(context).size.width *.25,
            height: MediaQuery.of(context).size.width *.17,

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(text, style: TextStyle(color: Colors.black, fontSize: 30)),
                                    )                  ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Tooltip(message: toolTip, child: Text(main, maxLines: 1,
              overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold, ),)),),
            )
          ],
        ),
      ),
    );
  }
}
