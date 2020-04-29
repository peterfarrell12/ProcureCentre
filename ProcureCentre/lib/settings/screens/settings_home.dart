import 'package:ProcureCentre/home/widgets/colours.dart';
import 'package:ProcureCentre/settings/bloc/bloc.dart';
import 'package:ProcureCentre/settings/models/settings_tab.dart';
import 'package:ProcureCentre/settings/screens/settings_display.dart';
import 'package:ProcureCentre/settings/screens/settings_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsHome extends StatefulWidget {
  @override
  _SettingsHomeState createState() => new _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .93,
      child: new Scaffold(

        body: Container(
          child: new Column(
            children: <Widget>[
                                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Settings",
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

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Container(
                  // decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                  child: new TabBar(
                    controller: _controller,
                    labelColor: Theme.of(context).primaryColor,
                    indicatorColor: Theme.of(context).primaryColor,
                    tabs: [
                      new Tab(
                        icon: const Icon(Icons.color_lens),
                        text: 'Display',
                      ),
                      new Tab(
                        icon: const Icon(Icons.assignment_ind),
                        text: 'User',
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                height: MediaQuery.of(context).size.height * .5,
                child: new TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    Container(child: SettingsDisplay(),),
                    Container(child: SettingsUser(),)

                  ],
                ),
              ),


              
            ],
          ),
        ),
      ),
    );
  }
}
