import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:flutter/material.dart';

class ExtractedScreen extends StatefulWidget {
  @override
  _ExtractedScreenState createState() => _ExtractedScreenState();
}

class _ExtractedScreenState extends State<ExtractedScreen> {

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Spend Data Extraction"),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.of(context).pop();},)
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Spend Data Extraction Dashboard"),
          ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
               RaisedButton(onPressed: null, child: Text('Add More Data'),),
               RaisedButton(onPressed: null, child: Text('Replace Data'),),
               RaisedButton(onPressed: null, child: Text('Other Option'),) ]
           ,),
         ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              
                        child: Container(
                          child: DataTable(
      columns: [
        DataColumn(label: Text("Invoice")),
        DataColumn(label: Text("Order")),
        DataColumn(label: Text("Date")),
        DataColumn(label: Text("Currency")),
        DataColumn(label: Text("Code")),
        DataColumn(label: Text("Description")),
        DataColumn(label: Text("Qty")),
        DataColumn(label: Text("UOM")),
        DataColumn(label: Text("Price")),
        DataColumn(label: Text("Total")),

      ],
      rows: 
      sampleList.map((item) => DataRow(
        cells: [
              DataCell (
                Text(item.date.toString())
              ),
     
              DataCell (
                Text(item.qty.toString())
              ),
                DataCell (
                Text(item.description.toString())
              ),
                DataCell (
                Text(item.price.toString())
              ),
                 DataCell (
                Text(item.total.toString())
              ),
                 DataCell (
                Text(item.uom.toString())
              ),
                             DataCell (
                Text(item.currency.toString())
              ),
                                  DataCell (
                Text(item.code.toString())
              ),
                                      DataCell (
                Text(item.invoice.toString())
              ),
                                      DataCell (
                Text(item.order.toString())
              ),

        ]
      )
      ).toList()),
                        ),
            ),
          )
        ],
      )
    );
  }
}