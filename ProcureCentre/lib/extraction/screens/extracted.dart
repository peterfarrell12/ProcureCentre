import 'package:ProcureCentre/extraction/blocs/extraction_bloc/bloc.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../project_repository.dart';

class ExtractedScreen extends StatefulWidget {
  final List<DataPoint> projectData;
  final Project project;

  ExtractedScreen({@required this.projectData, @required this.project});
  @override
  _ExtractedScreenState createState() => _ExtractedScreenState();
}

class _ExtractedScreenState extends State<ExtractedScreen> {
  List<DataPoint> get _projectData => widget.projectData;
  Project get _project => widget.project;
    ExtractionBloc _extractionBloc;


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ExtractionBloc, ExtractionState>(
      bloc: _extractionBloc,
      builder: (context, state) {
        return  Column(
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
                RaisedButton(
                  onPressed: () => _extractionBloc.add(NotExtracted(project: _project)),
                  child: Text('Add More Data'),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text('Replace Data'),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text('Other Option'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              child: SingleChildScrollView(
                child: DataTable(
                    columns: [
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text("Invoice")),
                      DataColumn(label: Text("Order")),
                      DataColumn(label: Text("Supplier")),
                      DataColumn(label: Text("Customer")),
                      DataColumn(label: Text("Code")),
                      DataColumn(label: Text("Description")),
                      DataColumn(label: Text("Qty")),
                      DataColumn(label: Text("UOM")),
                      DataColumn(label: Text("Price")),
                      DataColumn(label: Text("Total")),
                    ],
                    rows: _projectData
                        .map((item) => DataRow(cells: [
                              DataCell(Text(item.date)),
                              DataCell(Text(item.invoice)),
                              DataCell(Text(item.order)),
                              DataCell(Text(item.supplier)),
                              DataCell(Text(item.customer)),
                              DataCell(Text(item.code)),
                              DataCell(Text(item.description)),
                              DataCell(Text(item.qty)),
                              DataCell(Text(item.uom)),
                              DataCell(Text(item.price)),
                              DataCell(Text(item.total)),
                            ]))
                        .toList()),
              ),
            ),
          )
        ],
      );
      }
    );
  }
}
