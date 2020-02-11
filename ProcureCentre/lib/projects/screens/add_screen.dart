import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:ProcureCentre/projects/bloc/blocs.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart' as fb;
import 'package:multiselect_formfield/multiselect_formfield.dart';


//typedef OnSaveCallback = Function(String name, String user, bool completed,);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  //final OnSaveCallback onSave;
  final Project project;
  final User user;

  AddEditScreen({
    Key key,
    //@required this.onSave,
    @required this.isEditing,
    @required this.user,
    this.project,
  }) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {

   String _name;
  //String _user;
  String _description;
  String owner;
  List<String> teamMembers;
  bool add = false;

  bool get isEditing => widget.isEditing;
  User get _userName => widget.user;

   static fs.Firestore store = fb.firestore();
  Stream<fs.QuerySnapshot> users;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProjectsBloc _projectsBloc;

  @override
  void initState() {
    super.initState();
    _projectsBloc = BlocProvider.of<ProjectsBloc>(context);
    users = store.collection("companies").doc(_userName.company.toString()).collection('users').get().asStream().asBroadcastStream();

  }

 

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ProjectsBloc, ProjectsState>(builder: (context, state) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              isEditing ? 'Edit Project' : 'Add Project',
              style: TextStyle(color: Colors.blue),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),

        content: Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.height * .5,
              child: SingleChildScrollView(
                              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
        Column(
          children: <Widget>[
            TextFormField(
                decoration: InputDecoration(
                  labelText: 'Project Name',
                ),
                autofocus: true,
                validator: (val) {
                  return val.trim().isEmpty
                      ? 'Please enter some text'
                      : null;
                },
                onSaved: (value) => _name = value,
            ),
            TextFormField(
                minLines: 2,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Project Description',
                ),
                autofocus: true,
                validator: (val) {
                  return val.trim().isEmpty
                      ? 'Please enter some text'
                      : null;
                },
                onSaved: (value) => _description = value,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<fs.QuerySnapshot>(
                        stream: users,
                        builder: (BuildContext context,
                            AsyncSnapshot<fs.QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return new Text('Loading...');
                            default:
                              return FormField(
                                builder: (FormFieldState state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Project Owner',
                                    ),
                                    isEmpty:
                                        owner == "Choose Owner...",
                                    child: new DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: owner,
                                        isDense: true,
                                        onChanged: (dynamic newValue) {
                                          setState(() {
                                            owner = newValue;
                                            state.didChange(newValue);
                                          });
                                        },
                                        items: snapshot.data.docs.map(
                                            (fs.DocumentSnapshot document) {
                                          return new DropdownMenuItem(
                                            value: document
                                                .data()['Username'],
                                            child: new Text(document
                                                .data()['Username']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                          }
                        }),
            ),
            
          ]
            
             
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            tooltip: isEditing ? 'Save changes' : 'Add Project',
            child: Icon(isEditing ? Icons.check : Icons.check),
            onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  //widget.onSave(_name, _user, false);
                  //BlocProvider.of<ProjectsBloc>(context).
                  _onFormSubmitted();
                  _projectsBloc.asBroadcastStream();

                  Navigator.of(context).pop();
                }
            },
          ),
        ),
                  ],
                ),
              ),
            ),
          ),
       
      );
    });
  }

  void _onFormSubmitted() {
    _projectsBloc.add(
      AddProject(
          Project(
            owner,
            name: _name,
            complete: false,
            description: _description,
             created: DateTime.now(),
             status: 'Initial',
             teamMembers: teamMembers,
            extraction: {'Completed': false},
            classification: {'Completed': false},
            dashboard: {'Completed': false},
            tenderCreation: {'Completed': false},
             //fileNames: ['test']
          ),
          _userName.company),
    );
  }

 
}
