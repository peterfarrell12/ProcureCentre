import 'package:ProcureCentre/dashboard/Widgets/choice_chip.dart';
import 'package:ProcureCentre/dashboard/Widgets/insight_creator.dart';
import 'package:ProcureCentre/dashboard/Widgets/multi_filter_chip.dart';
import 'package:ProcureCentre/dashboard/bloc/dashboard_bloc.dart';
import 'package:ProcureCentre/dashboard/screens/insights.dart';
import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:ProcureCentre/projects/firebase_project_repository.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:ProcureCentre/tender/bloc/tender_bloc.dart';
import 'package:ProcureCentre/tender/firebase_tender_repository.dart';
import 'package:ProcureCentre/tender/models/tender.dart';
import 'package:ProcureCentre/tender/screens/tender_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ProcureCentre/dashboard/helper/data_transformer.dart';

import 'chart_page_1.dart';
import 'chart_page_2.dart';
import 'chart_page_3.dart';
import 'dart:math';

Random random = new Random();

class DashboardScreen extends StatefulWidget {
  final Project project;
  final String company;

  DashboardScreen({@required this.project, @required this.company});
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _pageController = PageController(initialPage: 0);
  Project get _project => widget.project;
  String get _company => widget.company;
  DashboardBloc _dashboardBloc;
  TenderBloc _tenderBloc;
  List<DataPoint> data = [];
  List suppliers = [];
  String supplierFilter = 'all';
  String categoryFilter = 'all';


  //List<String> categoryList = [];
  //List<int> lengths = [7, 10, 14];
  //int length = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _dashboardBloc.close();
    _tenderBloc.close();
    super.dispose();
  }

  _checkFilters(List<DataPoint> d){
    if(categoryFilter == 'all' && supplierFilter == 'all'){
      return d;
    }
    else if(categoryFilter == 'all') {
      return d.where((element) => element.supplier == supplierFilter).toList();
    }
    else if(supplierFilter == 'all'){
            return d.where((element) => element.category == categoryFilter).toList();

    }
    else {
      return d.where((element) => element.supplier == supplierFilter).where((element) => element.category == categoryFilter).toList();

    }
  }

  _showReportDialog(List<DataPoint> data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          _tenderBloc = TenderBloc(
              tenderRepository: FirebaseTenderRepository(),
              projectRepository: FirebaseProjectRepository());
          //Here we will build the content of the dialog
          return
              //tenderNotCreated(context, data);
              BlocProvider<TenderBloc>(
            create: (context) => _tenderBloc,
            child: BlocBuilder<TenderBloc, TenderState>(
              bloc: _tenderBloc,
              builder: (context, state) {
                if (state is StateLoading) {
                  _tenderBloc.add(
                      CheckingStatus(project: _project, company: _company));
                } else if (state is TenderNotCreatedState) {
                  return tenderNotCreated(context, data);
                } else if (state is TenderCreatedState) {
                  return tenderCreated(context, state.tenders);
                } else if (state is CreatingTenderState) {
                  return AlertDialog(
                      title: Text('Creating Tender'),
                      content: Center(child: CircularProgressIndicator()));
                } else if (state is ViewingTenderState) {
                  return TenderHomeScreen(
                    tender: state.tender,
                    data: state.data,
                  );
                }
                return Container();
              },
            ),
          );
        });
  }

  AlertDialog tenderCreated(BuildContext context, List<Tender> tenders) {
    return AlertDialog(
      title: Text("Tenders List",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .4,
          width: MediaQuery.of(context).size.width * .3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: new LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    width: constraints.maxWidth,
                    height: 200,
                    child: ListView.builder(
                        itemCount: tenders.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return ListTile(
                            leading: Icon(
                              Icons.folder,
                              color: Colors.blue,
                            ),
                            title: Text(tenders[index].title,
                                style: TextStyle(
                                  color: Colors.blue,
                                )),
                            subtitle: Text(
                              tenders[index].created.toString(),
                            ),
                            onTap: () => _tenderBloc
                                .add(TenderChosen(tenders[index], _project)),
                          );
                        }),
                  );
                }),
              ),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => _tenderBloc.add(
                  TenderNotCreated(project: _project, company: _company),
                ),
              ),
            ],
          ),
        ),

        // Expanded(
        //   flex: 1,
        //                 child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Center(
        //           child: FlatButton(
        //               onPressed: () => _tenderBloc.add(TenderNotCreated(
        //                   project: _project, company: _company)),
        //               child: Text("Create New Tender?")))
        //     ],
        //   ),
        // )
      ),
    );
  }

  AlertDialog _getInsights(BuildContext context, List<DataPoint> data){
    // int number = random.nextInt(7) + 1;
    // print("Num = $number");
    // String insight = createInsight(6, data);
    // print("Insight == $insight");
    return AlertDialog(
      content: Insights(data: data),
    );
  }

  AlertDialog tenderNotCreated(BuildContext context, List<DataPoint> data) {
    int length;
    String title;
    String scope;
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _scopeController = TextEditingController();

    @override
    void initState() {
      super.initState();
    }

    int _value = 0;
    List<String> categoryList = [];
    List<int> lengths = [7, 10, 14];
    return AlertDialog(
      title: Text(
        "Tender Creator",
        style: TextStyle(color: Colors.blue),
      ),
      content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * .6,
            width: MediaQuery.of(context).size.width * .3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                        child: Text("Title"),
                      )),
                ),
                TextField(
                  controller: _titleController,
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
                        child: Text("Scope"),
                      )),
                ),
                TextField(
                  controller: _scopeController,
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
                        child: Text("Categories"),
                      )),
                ),
                MultiSelectChip(
                  categories(data),
                  onSelectionChanged: (selectedList) {
                    setState(() {
                      categoryList = selectedList;
                    });
                  },
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
                        child: Text("Length"),
                      )),
                ),
                LengthChoiceChip(lengths, (selected) {
                  setState(() {
                    length = selected;
                  });
                }
                    //print(length);
                    //print(length);

                    ),

                //ChoiceChip(label: null, selected: null)
              ],
            ),
          )),
      actions: <Widget>[
        FlatButton(
            child: Text("Generate Tender"),
            onPressed: () {
              List<DataPoint> filteredData = [];
              for (int i = 0; i < categoryList.length; i++) {
                data.forEach((element) {
                  if (element.category == categoryList[i]) {
                    filteredData.add(element);
                  }
                });
              }
              List<String> ids = [];
              for (int i = 0; i < filteredData.length; i++) {
                ids.add(filteredData[i].id);
              }
              title = _titleController.text;
              scope = _scopeController.text;
              print(filteredData.length);
              _tenderBloc.add(TenderBegin(
                tender: Tender(
                    projectName: _project.name,
                    company: _company,
                    categories: categoryList,
                    created: DateTime.now(),
                    dPReferences: ids,
                    length: length,
                    user: _project.user,
                    scope: scope,
                    title: title),
                project: _project,
                company: _company,
              ));
            })
      ],
    );
  }

  _popUpSupplierFilter(BuildContext context, List data, String name) {
    // var supplierData = data.map((e) => e.supplier).toList();
    // var supplierSet = supplierData.toSet().toList();
    return PopupMenuButton(
        onSelected: (result) {
          setState(() {
            supplierFilter = result;
            print(result);
          });
        },
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("$name Filter"),
                  supplierFilter != 'all' ? IconButton(icon: Icon(Icons.cancel), onPressed: () {
                    setState(() {
                      supplierFilter = 'all';
                    });
                  },) : Container()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.filter_list,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            )
          ],
        ),
        itemBuilder: (context) => data
            .map((e) => PopupMenuItem(
              value: e,
              child: Text(e)))
            .toSet()
            .toList());
  }

    _popUpCategoryFilter(BuildContext context, List data, String name) {
    // var supplierData = data.map((e) => e.supplier).toList();
    // var supplierSet = supplierData.toSet().toList();
    return PopupMenuButton(
        onSelected: (result) {
          setState(() {
            categoryFilter = result;
            print(result);
          });
        },
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("$name Filter"),
                  categoryFilter != 'all' ? IconButton(icon: Icon(Icons.cancel), onPressed: () {
                    setState(() {
                      categoryFilter = 'all';
                    });
                  },) : Container()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.filter_list,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            )
          ],
        ),
        itemBuilder: (context) =>
        
        data
            .map((e) => PopupMenuItem(
              value: e,
              child: Text(e)))
            .toSet()
            .toList()
      )
            ;
  }



  @override
  Widget build(BuildContext context) {
    _dashboardBloc = DashboardBloc(
        extractionRepository: FirebaseExtractionRepository(),
        projectRepository: FirebaseProjectRepository());
    _dashboardBloc.add(DashboardLoading(project: _project, company: _company));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Dashboard Screen"),
      ),
      body: BlocProvider<DashboardBloc>(
        create: (context) => _dashboardBloc,
        child: BlocBuilder<DashboardBloc, DashboardState>(
          bloc: _dashboardBloc,
          builder: (context, state) {
            if (state is DashboardInitial) {
              _dashboardBloc
                  .add(DashboardLoading(project: _project, company: _company));
            } else if (state is DashboardLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DashboardLoadedState) {
              print("Hello$data");
                  var supplierData = state.data.map((e) => e.supplier).toList();
                var supplierSet = supplierData.toSet().toList();
                                  var categoryData = state.data.map((e) => e.category).toList();
                var categorySet = categoryData.toSet().toList();
              return Container(
                child: Row(
                  children: <Widget>[
                    //TaskBar
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          right: BorderSide(
                            color: Colors.blue,
                            // width: 3.0 --> you can set a custom width too!
                          ),
                        )),
                        width: MediaQuery.of(context).size.width * .15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: <Widget>[
                            //     IconButton(icon: Icon(Icons.more), onPressed: null),
                            //     IconButton(icon: Icon(Icons.filter_1), onPressed: null),
                            //   ],
                            // ),
                            Container(
                              child: Text(
                                "Dashboard Control",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),

                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        // width: 3.0 --> you can set a custom width too!
                                      ),
                                    )),
                                    child: FlatButton(
                                      child: Text("Info"),
                                      onPressed: () =>
                                          _pageController.jumpToPage(0),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        // width: 3.0 --> you can set a custom width too!
                                      ),
                                    )),
                                    child: FlatButton(
                                      child: Text("Chart 1"),
                                      onPressed: () =>
                                          _pageController.jumpToPage(1),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        // width: 3.0 --> you can set a custom width too!
                                      ),
                                    )),
                                    child: FlatButton(
                                      child: Text("Chart 2"),
                                      onPressed: () =>
                                          _pageController.jumpToPage(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              
                
                              child: _popUpSupplierFilter(context, supplierSet, "Supplier",)),
                            // Container(child: _popUpSupplierFilter(context, state.data)),
                            Container(
                              
                
                              child: _popUpCategoryFilter(context, categorySet, "Category",)),

                            Column(
                                children: <Widget>[
                                  Container(
                                    child: Text("Insights"),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.bubble_chart,
                                          color: Theme.of(context).primaryColor),
                                      onPressed: () { 
                                        showDialog(
                                          
                                          context: context, 
                                    builder:  (_) => _getInsights(context, state.data));
                                      
                                      },
                                      
                                  )  
                         
                                ],
                              ),
                            Column(
                              children: <Widget>[
                                Container(
                                  child: Text("Export"),
                                ),
                                IconButton(
                                    icon: Icon(Icons.file_download,
                                        color: Theme.of(context).primaryColor),
                                    onPressed: null)
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  child: Text("Tender"),
                                ),
                                IconButton(
                                    icon: Icon(
                                        FontAwesomeIcons.caretSquareRight,
                                        color: Theme.of(context).primaryColor),
                                    onPressed: () =>
                                        _showReportDialog(state.data))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .85,
                      child: 
                      PageView(
                        controller: _pageController,
                        children: <Widget>[
                          ChartPageOne(
                              press: () => _pageController.jumpToPage(1),
                              data: _checkFilters(state.data)),
                              // data: categoryFilter == 'all'
                              //     ? state.data
                              //     : state.data
                              //         .where((element) =>
                              //             element.category == categoryFilter)
                              //         .toList()),
                          ChartPageTwo(
                            pressLeft: () => _pageController.jumpToPage(0),
                            pressRight: () => _pageController.jumpToPage(2),
                            data: state.data,
                          ),
                          ChartPageThree(
                            pressLeft: () => _pageController.jumpToPage(1),
                            data: state.data,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Text('error');
            }
            return Container();
          },
        ),
      ),
    );
  }
}
