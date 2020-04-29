import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
import 'package:ProcureCentre/home/bloc/home_screen_bloc/bloc.dart';
import 'package:ProcureCentre/home/widgets/colours.dart';
import 'package:ProcureCentre/project_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../firebase_home_repository.dart';

class Home extends StatefulWidget {
  final String company;

  const Home({Key key, @required this.company}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeScreenBloc _homeScreenBloc;
  String get _company => widget.company;
  List table1Rows;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    print(_company);
    return BlocProvider<HomeScreenBloc>(
      create: (context) {
        return HomeScreenBloc(FirebaseHomeRepository())
          ..add(LoadData(_company));
      },
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [Container(
                    child: Center(child: CircularProgressIndicator()))]);
          } else if (state is HomeScreenLoaded) {
            List<Table1> data = state.companyData['Table 1'].toList();
            List<Table2> data2 = state.companyData['Table 2'].toList();

            return Container(
              width: w * .93,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Scaffold(
                    body: Container(
                        child: SingleChildScrollView(
                            child: Column(children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Home",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w700,
                          fontSize: 29,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "Peter's Company",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "Peterf4282",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ]))),
                  Align(
                    alignment: Alignment.topCenter,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 253,
                              height: 195,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 13),
                                      child: Text(
                                        state.companyData['Users'].toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: "Helvetica",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 18, top: 22, right: 18),
                                    child: Text(
                                      "Company Users",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 253,
                              height: 195,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 13),
                                      child: Text(
                                        state.companyData['Projects']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: "Helvetica",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 3, top: 22, right: 3),
                                    child: Text(
                                      "Company Projects",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 253,
                              height: 195,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 13),
                                      child: Text(
                                        state.companyData['Active'].toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: "Helvetica",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 26, top: 22, right: 26),
                                    child: Text(
                                      "Active Projects",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 253,
                              height: 195,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 13),
                                      child: Text(
                                        state.companyData['Tenders'].toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: "Helvetica",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 15, top: 22, right: 15),
                                    child: Text(
                                      "Tenders Created",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
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
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: w * .2,
                      height: 1,
                      //margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryText,
                      ),
                      child: Container(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: w * .4,
                            child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.white),
                                child: DataTable(
                                    showCheckboxColumn: false,
                                    columns: [
                                      DataColumn(
                                          label: Center(
                                              child: Text(
                                        "Users",
                                        style: TextStyle(
                                            fontFamily: "Helvetica",
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ))),
                                      DataColumn(
                                          label: Center(
                                              child: Text(
                                        "Projects",
                                        style: TextStyle(
                                            fontFamily: "Helvetica",
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ))),
                                      DataColumn(
                                          label: Center(
                                              child: Text(
                                        "Active",
                                        style: TextStyle(
                                            fontFamily: "Helvetica",
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ))),
                                      DataColumn(
                                          label: Center(
                                              child: Text(
                                        "Tenders",
                                        style: TextStyle(
                                            fontFamily: "Helvetica",
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ))),
                                    ],
                                    rows: data
                                        .map(
                                          (item) => DataRow(
                                            cells: [
                                              DataCell(Center(
                                                  child: Text(item.user,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .primaryText,
                                                        fontFamily: "Helvetica",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 20,
                                                      )))),
                                              DataCell(Center(
                                                  child: Text(
                                                      item.projects
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .primaryText,
                                                        fontFamily: "Helvetica",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 20,
                                                      )))),
                                              DataCell(Center(
                                                  child: Text(
                                                      item.active.toString(),
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .primaryText,
                                                        fontFamily: "Helvetica",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 20,
                                                      )))),
                                              DataCell(
                                                Center(
                                                  child: Text(
                                                    item.tenders.toString(),
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.primaryText,
                                                      fontFamily: "Helvetica",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ).toList()
                                        )),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: w * .4,
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.white),
                              child: DataTable(
                                showCheckboxColumn: false,
                                columns: [
                                  DataColumn(
                                      label: Center(
                                          child: Text(
                                    "Feature",
                                    style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor),
                                  ))),
                                  DataColumn(
                                      label: Center(
                                          child: Text(
                                    "Projects",
                                    style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor),
                                  ))),
                                  DataColumn(
                                      label: Center(
                                          child: Text(
                                    "Percentage",
                                    style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor),
                                  ))),

                                ],
                                rows: data2.map((item) => 
                                  DataRow(cells: [
                                    DataCell(Center(
                                        child: Text(item.feature,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "Helvetica",
                                              fontWeight: FontWeight.w300,
                                              fontSize: 20,
                                            )))),
                                    DataCell(Center(
                                      child: Text(item.projects.toString(),
                                          style: TextStyle(
                                            color: AppColors.primaryText,
                                            fontFamily: "Helvetica",
                                            fontWeight: FontWeight.w300,
                                            fontSize: 20,
                                          )),
                                    )),
                                    DataCell(Center(
                                        child: Text("${item.percentage.round()}%",
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "Helvetica",
                                              fontWeight: FontWeight.w300,
                                              fontSize: 20,
                                            )))),

                                  ])
                                ).toList()
                                  

                                  
                                  
                                
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: w * .2,
                      height: 1,
                      margin: EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                        color: AppColors.primaryText,
                      ),
                      child: Container(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.only(top: 30),
                      width: 496,
                      // height: 301,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.all(16.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: "Data Extracted from",
                                  style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontFamily: "Helvetica",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                  ),
                                ),
                                TextSpan(
                                  text: " 1200",
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontFamily: "Helvetica",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                  ),
                                ),
                                TextSpan(
                                  text: " Invoices",
                                  style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontFamily: "Helvetica",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.all(16.0),
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 50, color: Colors.white),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "15000",
                                      style: TextStyle(
                                        color: AppColors.secondaryText,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Lines Of Data Classified",
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,

                            padding: EdgeInsets.all(16.0),
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 50, color: Colors.white),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "62%",
                                      style: TextStyle(
                                        color: AppColors.secondaryText,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          " Of Projects Have Been Fully Completed",
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ]),
                            ),

                            // Text(
                            //   "Data Extracted from 1200 Invoices",
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     color: AppColors.primaryText,
                            //     fontFamily: "Helvetica",
                            //     fontWeight: FontWeight.w300,
                            //     fontSize: 20,
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ])))),
              ),
            );
          } else if (state is HomeScreenNotLoaded) {
            return Container(
              child: Center(child: Text("Network Error")),
            );
          }
        },
      ),
    );
  }
}
