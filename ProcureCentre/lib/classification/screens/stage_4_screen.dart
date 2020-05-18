
import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
import 'package:ProcureCentre/classification/widgets/export_to_csv.dart';
import 'package:ProcureCentre/dashboard/screens/dashboard_screen.dart';


import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/project_repository.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class ClassificationScreenStage4Widget extends StatefulWidget {
  final Project project;
  final String company;

  const ClassificationScreenStage4Widget({
    Key key,
    @required this.project,
    @required this.company,
  }) : super(key: key);
  @override
  _ClassificationScreenStage4WidgetState createState() =>
      _ClassificationScreenStage4WidgetState();
}

class _ClassificationScreenStage4WidgetState
    extends State<ClassificationScreenStage4Widget> {
  Project get _project => widget.project;
  String get _company => widget.company;
  List<DataPoint> _projectData  = [];
  final _classificationBloc = ClassificationBloc(extractionRepository: FirebaseExtractionRepository(), projectRepository: FirebaseProjectRepository());
  Future<void> _getData(Project project, String company) async {
    List<DataPoint> data =
        await FirebaseExtractionRepository().getData(project, company);
    setState(() {
      _projectData = data;
    });
      var cat = [];
    for(int i =0; i < _projectData.length; i++){
      if (_projectData[i].category.isNotEmpty){
      cat.add(_projectData[i].category);
      }
    }
    print(" PD ${_projectData.length}");
    print(cat.length);
     if (cat.length != _projectData.length){
      print('Should Show');
      _showEmptyDialog();
      }
  }

  // void onNewExtractPressed(BuildContext context) async {
  // }

    void onDashboardPressed(BuildContext context) async {
        Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DashboardScreen(project: _project, company: _company,);
                                    //ClassificationMain(project: state.currentProject, company: _company);
                                                                      },
                                                                    ),
                                                                  );
  }

  List<DataPoint> selectedData;
  bool sort;

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 10) {
      if (ascending) {
        _projectData.sort((a, b) => a.total.compareTo(b.total));
      } else {
        _projectData.sort((a, b) => b.total.compareTo(a.total));
      }
    }
  }

  onSelectedRow(bool selected, DataPoint user) async {
    setState(() {
      if (selected) {
        selectedData.add(user);
      } else {
        selectedData.remove(user);
      }
    });
  }
   void onStage1Pressed(BuildContext context) async {
    BlocProvider.of<ClassificationBloc>(context)
        .add(Stage1Pressed(project: _project, company: _company));
  }

  void onStage2Pressed(BuildContext context) async {
    BlocProvider.of<ClassificationBloc>(context).add(Stage2Pressed(
      project: _project,
      company: _company,
    ));
  }

  void onStage3Pressed(BuildContext context) async {
    BlocProvider.of<ClassificationBloc>(context).add(Stage4Pressed(
      project: _project,
      company: _company,
    ));
  }

  void _showEmptyDialog() {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Warning - Unclassified Data"),
          content: new Text("Some Of Your Data Is Not Classified, If You Wish To Classify This Data Please Go To Stage 1"),
          actions: <Widget>[
                        new FlatButton(
              child: new Text("Close", style: TextStyle(color: Theme.of(context).primaryColor),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            
            ),
          ],
        );
      },
    );
    }
  
  //ClassificationBloc _ClassificationBloc;
  @override
  void initState(){
    sort = false;
    selectedData = [];
      _getData(_project, _company);
  

    //_projectData = FirebaseClassificationRepository().getData(_project, _company);
    super.initState();
  }

@override
  void dispose() {
    // TODO: implement dispose
    _classificationBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return _projectData.length == 0 ? Align(          alignment: Alignment.topCenter,
 child: Container(
   padding: EdgeInsets.all(16),
   child: CircularProgressIndicator())) :
    
    
    Container(
        child: Column(children: [
      Align(
          alignment: Alignment.topCenter,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              margin: EdgeInsets.only(top: 51),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
        GestureDetector(
          onTap: () => onStage1Pressed(context),
                  child: Container(
            width: 201,
            height: 55,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              border: Border.all(
                width: 1,
                color: Color.fromARGB(255, 151, 151, 151),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Stage 1",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 109, 114, 120),
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
                    onTap: () => onStage2Pressed(context),

                  child: Container(
            width: 201,
            height: 55,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              border: Border.all(
                width: 1,
                color: Color.fromARGB(255, 151, 151, 151),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Stage 2",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 109, 114, 120),
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
                GestureDetector(
                            onTap: () => onStage3Pressed(context),

                                  child: Container(
          width: 201,
          height: 55,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border.all(
              width: 1,
              color: Color.fromARGB(255, 151, 151, 151),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Stage 3",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 109, 114, 120),
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
              ),
            ],
          ),
        ),
                ),

                Container(
          width: 201,
          height: 55,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,

            //color: Color.fromARGB(255, 105, 182, 23),
            border: Border.all(
              width: 1,
              color: Color.fromARGB(255, 151, 151, 151),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Stage 4",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
                ],
              ),
            ),
          ),
      ),
      Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              onPressed: () => onStage1Pressed(context),
                              child: Text(
                                "New",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 109, 114, 120),
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                                                        RaisedButton(
                              onPressed: () => getCsv(_project, _projectData),
                              child: Text(
                                "Export",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 109, 114, 120),
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () => onDashboardPressed(context),
                              child: Text(
                                "Dashboard",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 109, 114, 120),
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ])),
      Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            //height: double.infinity,
            child: Column(children: [


              Align(
                alignment: Alignment.topCenter,
                child: Container(
        // width: 598,
        margin: EdgeInsets.only(top: 46, right: 23),
        child: Text(
          "Classified Data Table",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 109, 114, 120),
            fontFamily: "Helvetica",
            fontWeight: FontWeight.w300,
            fontSize: 20,
          ),
        ),
                ),
              ),
              Container(
                            height: MediaQuery.of(context).size.height * .5,

                child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
              sortColumnIndex: 0,
              sortAscending: sort,
              showCheckboxColumn: false,
              columns: [
                                DataColumn(label: Text("Category")),

                DataColumn(label: Text('Date')),
                DataColumn(label: Text("Invoice")),
                DataColumn(label: Text("Order")),
                DataColumn(label: Text("Supplier")),
                DataColumn(label: Text("Customer")),
                DataColumn(label: Text("Code")),
                DataColumn(label: Text("Description")),
                DataColumn(label: Text("Qty"), numeric: true),
                DataColumn(label: Text("UOM")),
                DataColumn(label: Text("Price"), numeric: true),
                DataColumn(
                    label: Text("Total"),
                    numeric: true,
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        sort = !sort;
                      });
                      onSortColumn(columnIndex, ascending);
                    })
              ],
              rows: _projectData
                  .map((item) => DataRow(
                          selected: selectedData.contains(item),
                          onSelectChanged: (b) {
                            print("Onselect${item.price}");
                            onSelectedRow(b, item);
                          },
                          cells: [
                            DataCell(Text(item.category)),
                            DataCell(
                              Text(item.date),
                              onTap: () {
                                print('Selected ${item.date}');
                              },
                            ),
                            DataCell(Text(item.invoice)),
                            DataCell(Text(item.order)),
                            DataCell(Text(item.supplier)),
                            DataCell(Text(item.customer)),
                            DataCell(Text(item.code)),
                            DataCell(Text(item.description)),
                            DataCell(Text(item.qty)),
                            DataCell(
                              item.uom.length == 0
                                  ? Text('Each')
                                  : Text(item.uom),
                            ),
                            DataCell(Text(
                              "€ ${item.price}",
                              maxLines: 1,
                            )),
                            DataCell(
                              Text(
                                "€ ${item.price}",
                                maxLines: 1,
                              ),
                            ),
                          ]))
                  .toList()),
        ),
                ),
              ),

            ]),
          ),

          
      )
    ]));
  }
    }