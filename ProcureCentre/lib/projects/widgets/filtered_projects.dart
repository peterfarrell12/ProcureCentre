import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:ProcureCentre/projects/bloc/blocs.dart';
import 'package:ProcureCentre/projects/bloc/current_project/bloc.dart';
import 'package:ProcureCentre/projects/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteredProject extends StatefulWidget {
  final User user;
  FilteredProject({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _FilteredProjectState createState() => _FilteredProjectState();
}

class _FilteredProjectState extends State<FilteredProject> {
  User get _user => widget.user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredProjectsBloc, FilteredProjectState>(
      builder: (context, state) {
        if (state is FilteredProjectLoading) {
          return LoadingIndicator();
        } else if (state is FilteredProjectLoaded) {
          final projects = state.filteredProject;
          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return ProjectItem(
                project: project,
                onDismissed: (direction) {
                  
                  BlocProvider.of<ProjectsBloc>(context)
                      .add(DeleteProject(project, widget.user.company));
             
                  Scaffold.of(context).showSnackBar(DeleteProjectSnackBar(
                    project: project,
                    onUndo: () => BlocProvider.of<ProjectsBloc>(context)
                        .add(AddProject(project, widget.user.company)),
                  ));
                },
                onTap: () async {
                  BlocProvider.of<CurrentProjectBloc>(context)
                      .add(GetCurrentProject(project));
              
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<ProjectsBloc>(context).add(
                    UpdateProject(project.copyWith(complete: !project.complete),
                        widget.user.company),
                  );
   
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
