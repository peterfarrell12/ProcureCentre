import 'package:ProcureCentre/projects/bloc/current_project/bloc.dart';

import 'package:ProcureCentre/projects/screens/classification_screen.dart';
import 'package:ProcureCentre/projects/screens/dashboard_screen.dart';
import 'package:ProcureCentre/projects/screens/extraction_screen.dart';
import 'package:ProcureCentre/projects/screens/tender_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectBody extends StatefulWidget {
  ProjectBody();
  @override
  _ProjectBodyState createState() => _ProjectBodyState();
}

class _ProjectBodyState extends State<ProjectBody> {
  CurrentProjectBloc _currentProjectBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentProjectBloc, CurrentProjectState>(
      bloc: _currentProjectBloc,
      builder: (context, state) {
        if (state is CurrentProjectLoaded) {
          return Container(
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                //                   <--- left side
                color: Colors.grey,
                width: 1.0,
              ),
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          state.currentProject.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                
                
                ),
                //Details Row
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: _infoCard(Icon(Icons.create, color: Colors.white), '27-Dec-1996', 'Created On', context),
                        ),
                         Container(
                          child: _infoCard(Icon(Icons.person_outline, color: Colors.white), state.currentProject.user, "Owner", context),
                        ),
                        //  Container(
                        //   child: _infoCard(cardIcon, titleText, subTitleText, context),
                        // ),

                      ],
                    ),
                  ),
                ),

                //Actions Row
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: _featureCard(
                              'Spend Data Extraction',
                              "Spend Classification involves using preprocessed, historic spend data to predict the category of the incoming data.",
                              Colors.lightBlueAccent,
                              _featureButton(
                                  ExtractionScreen(), Colors.lightBlue, context),
                                  context),
                        ),
                        Container(
                          child: _featureCard(
                              'Spend Classification',
                              "Spend Classification involves using preprocessed, historic spend data to predict the category of the incoming data.",
                              Colors.redAccent,
                              _featureButton(
                                  ClassificationScreen(), Colors.red, context),
                                  context),
                        ),
                        Container(
                          child: _featureCard(
                              'Dashboard',
                              "Spend Classification involves using preprocessed, historic spend data to predict the category of the incoming data.",
                              Colors.greenAccent,
                              _featureButton(
                                  DashboardScreen(), Colors.green, context),
                                  context),
                        ),
                        Container(
                          child: _featureCard(
                              'Tender Creation',
                              "Spend Classification involves using preprocessed, historic spend data to predict the category of the incoming data.",
                              Colors.amberAccent,
                            
                              _featureButton(
                                  TenderScreen(), Colors.amber, context),
                                  context),
                        )
                      ],
                    ),
                  ),
                ),
               
              ],
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                //                   <--- left side
                color: Colors.grey,
                width: 1.0,
              ),
            )),
            child: Center(
                child: Text(
              "Please Choose Project",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            )),
          );
        }
      },
    );
  }
}

_featureButton(page, Color color, context) {
  return RaisedButton(
      child: Icon(
        FontAwesomeIcons.solidArrowAltCircleRight,
        color: Colors.white,
      ),
      //Text(buttonText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      color: color,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return page;
            },
          ),
        );
      });
}

_featureCard(title, description, Color color, _featureButton, context) {
  return Card(
    color: color,
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(

                          child: Container(
                            width: MediaQuery.of(context).size.width * .13,
                child: Text(description, overflow: TextOverflow.clip,
                maxLines: 5,
                    style: TextStyle(
                      color: Colors.white,
                      
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: _featureButton,
            ),
          )
        ],
      ),
    ),
  );
}

_infoCard(Icon cardIcon, String titleText, String subTitleText, context){
  return Container(
    width: MediaQuery.of(context).size.width * .2,
    // decoration: BoxDecoration(
    //   border: Border.all(
    //   width: 3.0
    // ),
    // borderRadius: BorderRadius.all(
    //     Radius.circular(10.0) //       
    // ),
 //),
    
    child: Card(

      elevation: 5,
      color: Colors.lightBlue,
      child: ListTile(
        leading: cardIcon,
        title: Text(titleText, style: TextStyle(color: Colors.white)),
        subtitle: Text(subTitleText,style: TextStyle(color: Colors.white)),
      ),
    ),
  );
}