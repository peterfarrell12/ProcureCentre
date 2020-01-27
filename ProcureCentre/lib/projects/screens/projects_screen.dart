import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:ProcureCentre/projects/bloc/blocs.dart';
import 'package:ProcureCentre/projects/bloc/current_project/bloc.dart';
import 'package:ProcureCentre/projects/screens/add_screen.dart';
import 'package:ProcureCentre/projects/widgets/project_body.dart';
import 'package:ProcureCentre/projects/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../firebase_project_repository.dart';

class ProjectsScreen extends StatefulWidget {
  final User user;
  ProjectsScreen({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  User get _user => widget.user;
  //ProjectsBloc _projectsBloc;
  //Project _currentProject;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectsBloc>(
      create: (context) {
        return ProjectsBloc(
          projectsRepository: FirebaseProjectRepository(),
        )..add(LoadProjects(_user.company));
      },
      child: Container(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CurrentProjectBloc>(
              create: (context) => CurrentProjectBloc(),
            ),
            BlocProvider<TabBloc>(
              create: (context) => TabBloc(),
            ),
            BlocProvider<FilteredProjectsBloc>(
                create: (context) => FilteredProjectsBloc(
                      user: _user,
                      projectsBloc: BlocProvider.of<ProjectsBloc>(context),
                    ))
          ],
          child: BlocBuilder<ProjectsBloc,ProjectsState>(
            builder: (context, state) {
            
            return Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .93,
                  height: double.infinity,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('${_user.company} Projects'),
                      actions: [
                                    IconButton(icon: Icon(Icons.refresh), iconSize: 20, color: Colors.white, onPressed: (){
                                      BlocProvider.of<ProjectsBloc>(context)
                      .add(LoadProjects(_user.company));
                                    }),

                        FilterButton(
                            visible: true, 
                            user: _user),
                          
                        IconButton(icon: Icon(Icons.more_vert), iconSize: 20, color: Colors.white, onPressed: (){},),
                      ],
                    ),
                    body: //ctiveTab == AppTab.projects
                        //?
                        Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * .25,
                          height: double.infinity,
                          child: FilteredProject(
                            user: _user,
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * .68,
                            height: double.infinity,
                            child: ProjectBody()),
                        
                      ],
                    ),
                    floatingActionButton: FloatingActionButton(
                          onPressed: (){
                                    Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return       BlocProvider<ProjectsBloc>(
              create: (context) => ProjectsBloc(
                projectsRepository: FirebaseProjectRepository(),
              ), child: AddEditScreen(isEditing: false, user: _user,));
      
            }),
          );
                            
                          } ,
                          child: Icon(Icons.add),
                          tooltip: "Add A New Project",
                        ) ,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
    //:
    //Container(child: Text('Hi'),),

    // bottomNavigationBar: TabSelector(
    //   activeTab: activeTab,
    //   onTabSelected: (tab) =>
    //       BlocProvider.of<TabBloc>(context)
    //           .add(UpdateTab(tab)),
    // ),
  }
  @override
 void dispose() {
   super.dispose();
 }
}
