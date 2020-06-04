import 'package:ProcureCentre/dashboard/Widgets/export_to_pdf.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/projects/bloc/current_project/current_project_bloc.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:ProcureCentre/projects/screens/projects_screen.dart';
import 'package:ProcureCentre/tender/models/tender.dart';
import 'package:ProcureCentre/tender/widgets/export_to_csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TenderHomeScreen extends StatefulWidget {
  final Tender tender;
  final List<DataPoint> data;

  const TenderHomeScreen({Key key, this.tender, this.data}) : super(key: key);

  @override
  _TenderHomeScreenState createState() => _TenderHomeScreenState();
}

class _TenderHomeScreenState extends State<TenderHomeScreen> {
  Tender get _tender => widget.tender;
  List<DataPoint> get _data => widget.data;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          "${_tender.company} - ${_tender.title}",
          style: TextStyle(color: Colors.blue),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
            child: Container(
              child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Title", style: TextStyle(color: Colors.blue),),
                          )),
                    ),
                    Text(
                      "${_tender.title}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Scope", style: TextStyle(color: Colors.blue),),
                          )),
                    ),
                    Text(
                      "${_tender.scope}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Owner", style: TextStyle(color: Colors.blue),),
                                  )),
                            ),
                            Text(
                      "${_tender.user}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                          ],
                        ),
                      Column(
                        children: <Widget> [
                           Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Length", style: TextStyle(color: Colors.blue),),
                          )),
                    ),
                    Text(
                      "${_tender.length} Days",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                        ]
                      )
                    ],
                    ),
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                // width: 3.0 --> you can set a custom width too!
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Pricing", style: TextStyle(color: Colors.blue),),
                          )),
                    ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       child: SingleChildScrollView(
                                            child: DataTable(
                              columns: [
              
                                DataColumn(label: Text("Code")),
                                DataColumn(label: Text("Description")),
                                DataColumn(label: Text("Qty")),
                                DataColumn(label: Text("UOM")),
                                DataColumn(label: Text("Price")),
                                DataColumn(label: Text("Total")),


                              ],
                              rows: 
                                  _data.map((item) => DataRow(cells: [
                                     
                                        DataCell(Text(item.code)),
                                        DataCell(Text(item.description)),
                                        DataCell(Text(item.qty)),
                                        DataCell(Text(item.uom)),
                                        DataCell(Text("€-")),
                                        DataCell(Text("€-")),

                                      ]))
                                  .toList()),
                       ),
                     ),
                   ),
                    
                ],
              ),
                  )),
            ),
          ),
          actions: <Widget>[
            //IconButton(icon: Icon(Icons.picture_as_pdf), onPressed: () => getPDF()),
            IconButton(icon: Icon(Icons.import_export), color: Colors.blue, onPressed: () => getCsv(_tender, _data), tooltip: "Export To CSV",)
          ],);
        // ));
  }
}
