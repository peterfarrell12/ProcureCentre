import 'dart:html' as html;

import 'package:ProcureCentre/classification/bloc/classification_bloc.dart';
import 'package:ProcureCentre/classification/screens/classification_main.dart';
import 'package:ProcureCentre/classification/screens/test_class.dart';
import 'package:ProcureCentre/dashboard/screens/dashboard_screen.dart';
import 'package:ProcureCentre/extraction/screens/extraction_home.dart';
import 'package:ProcureCentre/extraction/screens/extraction_main.dart';
import 'package:ProcureCentre/home/widgets/colours.dart';
import 'package:ProcureCentre/project_repository.dart';
import 'package:ProcureCentre/projects/bloc/current_project/bloc.dart';
import 'package:ProcureCentre/tender/screens/tender_home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

class ProjectBody extends StatefulWidget {
  final String company;
  ProjectBody(this.company);
  @override
  _ProjectBodyState createState() => _ProjectBodyState();
}

class _ProjectBodyState extends State<ProjectBody> {
  CurrentProjectBloc _currentProjectBloc;
  ClassificationBloc _classificationBloc;
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
                                color: Theme.of(context).primaryColor,
                                fontFamily: "Helvetica",
                                ),
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
                                        ? Theme.of(context).primaryColor
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
                                  style: TextStyle(color: Colors.white, fontFamily: 'Helvetica')),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                                                               Container(
                                                                padding: EdgeInsets.all(10),
                                                                child:
                                                              _featureButton(
                                                                () {
                                                                  Navigator.of(context).push(
                                                                    MaterialPageRoute(
                                                                      builder: (context) {
                                                                        return ExtractionMain (
                                      project: state.currentProject,
                                      company: _company,
                                     
                                    );
                                                                      },));}
                                                                      ,context, 
                                                                       "Extraction")),
 Container(
                                                                padding: EdgeInsets.all(10),
                                                                child:
                                                              _featureButton(
                                                                () {
                                                                  Navigator.of(context).push(
                                                                    MaterialPageRoute(
                                                                      builder: (context) {
                                                                        return  TestClass(project: state.currentProject, company: _company,);
                                                                      },));}
                                                                      ,context, 
                                                                       "Classification")),

                                                              Container(
                                                                padding: EdgeInsets.all(10),
                                                                child:
                                                              _featureButton(
                                                                () {
                                                                  Navigator.of(context).push(
                                                                    MaterialPageRoute(
                                                                      builder: (context) {
                                                                        return DashboardScreen(project: state.currentProject, company: _company,);
                                                                      },));}
                                                                      ,context, 
                                                                       "Dashboard"))
                                    
                                                            ],
                                                          ),
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
                                  Icon(Icons.create, color: Theme.of(context).primaryColor),
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
                                      color: Theme.of(context).primaryColor),
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
                                  TextStyle(fontSize: 20, color: Theme.of(context).primaryColor, fontFamily: 'Helvetica',),)
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
  return GestureDetector(
    onTap: _onPressed,

      child: Card(
      color: _buttonColor,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * .2,
                    height: MediaQuery.of(context).size.height * .1,

          child: Center(
            child: Text(
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
          ),
        ),
      ),
    ),
  );
}

_featureButton(
  _onPressed, context,title
){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: RaisedButton(hoverColor: Theme.of(context).primaryColor,onPressed: _onPressed, child: Text(title, style: TextStyle(fontFamily: 'Helvetica', color: AppColors.primaryText),)),
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

_noDataDialog(String text){
  return AlertDialog(title: Text("No Data!"),
  content: Text("There is no data to $text. Please Extract Some Data First"),);
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
