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
          return SingleChildScrollView(
                      child: Container(
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
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                              state.currentProject.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                            ),
                                                    ),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: _infoCard(
                                  Icon(Icons.create, color: Colors.blue),
                                  '27-Dec-1996',
                                  'Created On',
                                  context),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: _infoCard(
                                  Icon(Icons.person_outline, color: Colors.blue),
                                  state.currentProject.user,
                                  "Owner",
                                  context),
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: _descriptionCard("This is the description of the project", context),
                    ),
                  ),

                  //Actions Row
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: _featureCard(
                                  'Spend Data Extraction',
                                  "Spend Classification involves using preprocessed, historic spend data to predict the category of the incoming data.",
                                  Colors.lightBlueAccent,
                                  Colors.lightBlue,
                                  (){Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ExtractionScreen();
                    },
                  ),
                                  );},
                                  context),
                            ),
                            Container(
                              child: _featureCard(
                                  'Spend Classification',
                                  "Spend Classification involves using preprocessed, historic spend data to predict the category of the incoming data.",
                                  Colors.redAccent,
                                  Colors.red,
                                  (){Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ClassificationScreen();
                    },
                  ),
                                  );},
                                  context),
                            ),
                            Container(
                              child: _featureCard(
                                  'Dashboard',
                                  "Spend Classification involves using preprocessed, historic spend data to predict the category of the incoming data.",
                                  Colors.greenAccent,
                                  Colors.green,
                                 (){ Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return DashboardScreen();
                    },
                  ),
                                  );},
                                  context),
                            ),
                     
                        
                             Container(
                                child: _featureCard(
                  'Tender Creation',
                  "Spend Classification involves using preprocessed, historic spend data to predict the category of the incoming data.",
                  Colors.amberAccent,
                  Colors.amber,
                  (){Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return TenderScreen();
                      },
                    ),
                  );},
                  context),
                              ),
                            
                            
                          ],
                        ),
                      ),
                    ),
                ],
              ),
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

// _featureButton(page, Color color, context) {
//   return RaisedButton(
//       child: Icon(
//         FontAwesomeIcons.solidArrowAltCircleRight,
//         color: Colors.white,
//       ),
//       //Text(buttonText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//       color: color,
//       onPressed: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) {
//               return page;
//             },
//           ),
//         );
//       });
// }

_featureCard(
    title, description, Color color, Color _buttonColor, _onPressed, context) {
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
                child: Text(description,
                    overflow: TextOverflow.clip,
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
              child: RaisedButton(
                
                  child: Icon(
                    FontAwesomeIcons.solidArrowAltCircleRight,
                    color: Colors.white,
                  ),
                  //Text(buttonText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  color: _buttonColor,
                  onPressed: _onPressed),
            ),
          )
        ],
      ),
    ),
  );
}

_infoCard(Icon cardIcon, String titleText, String subTitleText, context) {
  return Container(
    width: MediaQuery.of(context).size.width * .2,
    child: Card(
      elevation: 5,
      color: Colors.white,
      child: ListTile(
        leading: cardIcon,
        title: Text(titleText, style: TextStyle(color: Colors.blue),overflow: TextOverflow.clip,maxLines: 1,),
        subtitle: Text(subTitleText, style: TextStyle(color: Colors.grey,),overflow: TextOverflow.clip,maxLines: 1,),
      ),
    ),
  );
}

_descriptionCard(String text, context){
  return Container(
    width: MediaQuery.of(context).size.width * .4,
        height: MediaQuery.of(context).size.height * .15,

    child: Card(
      elevation: 5,
      color: Colors.white,
      child: Center(child: Text(text, style: TextStyle(color: Colors.grey),))
    ),
  );
}

