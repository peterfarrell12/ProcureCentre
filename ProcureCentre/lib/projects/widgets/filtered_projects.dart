import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:ProcureCentre/project_repository.dart';
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
  //User get _user => widget.user;

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

                popUp:
                   PopupMenuButton<Status>(
      tooltip: 'Change Status',
      onSelected:(Status result) {
        String r;
        if (result == Status.initial) {
           r = 'Initial';
        }
        else if (result == Status.inProgress){
         r = 'In Progress';
        }
        else {
           r = 'Completed';
        }
          BlocProvider.of<ProjectsBloc>(context).add(
                    UpdateProject(project.copyWith(status: r),
                        widget.user.company),
                  );
      } ,
      itemBuilder: (BuildContext context) => <PopupMenuItem<Status>>[
        PopupMenuItem<Status>(
          value: Status.initial,
          child: Text(
            'Mark Inital',
          ),
        ),
         PopupMenuItem<Status>(
          value: Status.inProgress,
          child: Text(
            'Mark In Progress',  
          ),
        ),
                 PopupMenuItem<Status>(
          value: Status.completed,
          child: Text(
            'Mark Completed',  
          ),
        ),
        
      ],
      icon: Icon(Icons.filter_list),
    ),
                

                deleteTapped: (){
                  BlocProvider.of<ProjectsBloc>(context)
                      .add(DeleteProject(project, widget.user.company));
             
                  Scaffold.of(context).showSnackBar(DeleteProjectSnackBar(
                    project: project,
                    onUndo: () => BlocProvider.of<ProjectsBloc>(context)
                        .add(AddProject(project, widget.user.company)),
                  ));
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
