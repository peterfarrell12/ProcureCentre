import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassifiedScreen extends StatefulWidget {
   final List<DataPoint> projectData;
  final Project project;

    ClassifiedScreen({@required this.projectData, @required this.project});

  @override
  _ClassifiedScreenState createState() => _ClassifiedScreenState();
}

class _ClassifiedScreenState extends State<ClassifiedScreen> {
    List<DataPoint> get _projectData => widget.projectData;
  Project get _project => widget.project;
  ClassificationBloc _classificationBloc;
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassificationBloc, ClassificationState>(
      bloc: _classificationBloc,
      builder: (context, state) {
        return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Spend Data Classfication Dashboard", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  child: Text('Reclassify'),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text('Delete Data'),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text('Generate Dashboard'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,

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
                                              DataColumn(label: Text("Category")),


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
                                                              DataCell(Text(item.category)),

                              ]))
                          .toList()),
                ),
              ),
            ),
          )
        ],
      );
      }
    );
  }
}