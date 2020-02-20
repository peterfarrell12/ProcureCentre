import 'dart:html' as html;

import 'package:ProcureCentre/classification/screens/classification_screen.dart';
import 'package:ProcureCentre/extraction/firebase_extraction_repository.dart';
import 'package:ProcureCentre/extraction/screens/extraction_home.dart';
import 'package:ProcureCentre/project_repository.dart';
import 'package:ProcureCentre/projects/bloc/current_project/bloc.dart';

import 'package:ProcureCentre/projects/screens/dashboard_screen.dart';
import 'package:ProcureCentre/projects/screens/tender_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

class ProjectBody extends StatefulWidget {
  String company;
  ProjectBody(this.company);
  @override
  _ProjectBodyState createState() => _ProjectBodyState();
}

class _ProjectBodyState extends State<ProjectBody> {
  CurrentProjectBloc _currentProjectBloc;
  String get _company => widget.company;

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.currentProject.name,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: (state.currentProject.status == 'Initial')
                                ? Colors.redAccent
                                : (state.currentProject.status == 'In Progress')
                                    ? Colors.amber
                                    : (state.currentProject.status ==
                                            'Completed')
                                        ? Colors.greenAccent
                                        : Colors.grey,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  (state.currentProject.status == 'Initial')
                                      ? 'Initial'
                                      : (state.currentProject.status ==
                                              'In Progress')
                                          ? 'In Progress'
                                          : (state.currentProject.status ==
                                                  'Completed')
                                              ? 'Completed'
                                              : 'Status Not Found1',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        )
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
                                  DateFormat('dd-MMM-yyyy')
                                      .format(state.currentProject.created),
                                  //String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
                                  'Created On',
                                  context),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: _infoCard(
                                  Icon(Icons.person_outline,
                                      color: Colors.blue),
                                  state.currentProject.user,
                                  "Owner",
                                  context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Description
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Project Description",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: _descriptionCard(
                                state.currentProject.description, context),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Lists
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .3,
                              height: MediaQuery.of(context).size.height * .4,
                              child: _fileList(state.currentProject, context),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .3,
                              height: MediaQuery.of(context).size.height * .4,
                              child: _progressReport(
                                  state.currentProject, context),
                            ),
                          ),
                        ],
                      ),
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
                                Colors.lightBlue, ()  {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ExtractionHomeScreen (
                                      project: state.currentProject,
                                      company: _company,
                                     
                                    );
                                  },
                                ),
                              );
                            }, context),
                          ),
                          Container(
                            child: _featureCard(
                                'Spend Classification',
                                "Spend Classification involves using preprocessed, historic spend data to predict the category of the incoming data.",
                                Colors.redAccent,
                                Colors.red, () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ClassificationScreen(project: state.currentProject, company: _company);
                                  },
                                ),
                              );
                            }, context),
                          ),
                          Container(
                            child: _featureCard(
                                'Dashboard',
                                "Spend Classification involves using preprocessed, historic spend data to predict the category of the incoming data.",
                                Colors.greenAccent,
                                Colors.green, () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DashboardScreen();
                                  },
                                ),
                              );
                            }, context),
                          ),
                          Container(
                            child: _featureCard(
                                'Tender Creation',
                                "Spend Classification involves using preprocessed, historic spend data to predict the category of the incoming data.",
                                Colors.amberAccent,
                                Colors.amber, () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TenderScreen();
                                  },
                                ),
                              );
                            }, context),
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
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(subTitleText,
            style: TextStyle(fontSize: 20, color: Colors.blue)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * .2,
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: ListTile(
              leading: cardIcon,
              title: Text(
                titleText,
                style: TextStyle(color: Colors.grey),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
              //subtitle: Text(subTitleText, style: TextStyle(color: Colors.grey,),overflow: TextOverflow.clip,maxLines: 1,),
            ),
          ),
        ),
      ),
    ],
  );
}

_descriptionCard(String text, context) {
  return Container(
    width: MediaQuery.of(context).size.width * .4,
    height: MediaQuery.of(context).size.height * .15,
    child: Card(
        elevation: 5,
        color: Colors.white,
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.grey),
        ))),
  );
}

_fileList(Project project, context) {
  return Card(
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width * .3,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Project Files",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                //shrinkWrap: true,
                itemCount: project.fileNames?.length ?? 0,
                itemBuilder: (context, index) {
                  var keys = project.fileNames.keys.toList();

                  return ListTile(
                    leading: Icon(FontAwesomeIcons.filePdf),
                    title: Text(keys[index].toString()),
                    //subtitle: Text(project.fileNames[keys[index]]),
                    onTap: () =>_launchURL(project.fileNames[keys[index]]),
                  );
                },
              ),
            )
          ],
        ),
      ));
}

_progressReport(Project project, context) {
  return Card(
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width * .3,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Progress Report",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Project Creation'),
                    trailing: Icon(Icons.check_box, color: Colors.green),
                  ),
                  ListTile(
                    title: Text('Data Extraction'),
                    trailing: project.extraction['Completed']
                        ? Icon(Icons.check_box, color: Colors.green)
                        : Icon(Icons.close, color: Colors.red),
                  ),
                  ListTile(
                    title: Text('Spend Classification'),
                    trailing: project.classification['Completed']
                        ? Icon(Icons.check_box, color: Colors.green)
                        : Icon(Icons.close, color: Colors.red),
                  ),
                  ListTile(
                    title: Text('Dashboard Generation'),
                    trailing: project.dashboard['Completed']
                        ? Icon(Icons.check_box, color: Colors.green)
                        : Icon(Icons.close, color: Colors.red),
                  ),
                  ListTile(
                    title: Text('Tender Creation'),
                    trailing: project.tenderCreation['Completed']
                        ? Icon(Icons.check_box, color: Colors.green)
                        : Icon(Icons.close, color: Colors.red),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<Uri> uploadImageFile(html.File image, String imageName) async {
  print('loading');
  fb.StorageReference storageRef = fb.storage().ref('Test/$imageName');
  fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(image).future;

  Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
  print(imageUri);
  return imageUri;
}
