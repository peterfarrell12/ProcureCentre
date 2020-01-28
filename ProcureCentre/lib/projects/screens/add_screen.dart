import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:ProcureCentre/projects/bloc/blocs.dart';
import 'package:ProcureCentre/projects/models/project.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProjectsBloc _projectsBloc;

  @override
  void initState() {
    super.initState();
    _projectsBloc = BlocProvider.of<ProjectsBloc>(context);
  }

  String _name;
  String _user;

  bool get isEditing => widget.isEditing;
  User get _userName => widget.user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
          return Scaffold(
              
        appBar: AppBar(
            title: Text(
              isEditing ? 'Edit Project' : 'Add Project',
            ),
        
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: isEditing ? widget.project.name : '',
                    autofocus: !isEditing,
                    style: textTheme.headline,
                    decoration: InputDecoration(
          hintText: 'Please Enter The Name Of The Project?',
                    ),
                    validator: (val) {
          return val.trim().isEmpty ? 'Please enter some text' : null;
                    },
                    onSaved: (value) => _name = value,
                  ),
                  TextFormField(
                    initialValue:
            isEditing ? widget.project.user : _userName.username,
                    style: textTheme.subhead,
                    decoration: InputDecoration(
          hintText: 'Please ',
                    ),
                    onSaved: (value) => _user = value,
                  )
                ],
              ),
            ),
        ),
        floatingActionButton: FloatingActionButton(
            tooltip: isEditing ? 'Save changes' : 'Add Todo',
            child: Icon(isEditing ? Icons.check : Icons.save),
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
      );
      }
    );
  }

  void _onFormSubmitted() {
    _projectsBloc.add(
      AddProject(
        Project(_user, name: _name, complete: false),
        _userName.company
      ),
      
    );
    
  }
}
