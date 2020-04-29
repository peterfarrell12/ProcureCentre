import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:ProcureCentre/authentication/user/authentication_bloc/authentication_bloc.dart';
import 'package:ProcureCentre/authentication/user/authentication_bloc/authentication_event.dart';
import 'package:ProcureCentre/authentication/user/user_repository.dart';
import 'package:ProcureCentre/home/bloc/home_bloc/home_bloc.dart';
import 'package:ProcureCentre/home/bloc/home_bloc/home_event.dart';
import 'package:ProcureCentre/home/bloc/home_bloc/home_state.dart';
import 'package:ProcureCentre/home/screens/home.dart';
import 'package:ProcureCentre/projects/screens/projects_screen.dart';
import 'package:ProcureCentre/settings/screens/settings_home.dart';
import 'package:ProcureCentre/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  final UserRepository userRepository;

  HomeScreen({
    Key key,
    @required this.user,
    @required this.userRepository,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User get _user => widget.user;
  //UserRepository get _userRepository => widget.userRepository;
  HomeBloc _homeBloc;

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String _userName = _user.username;
    // String _email = _user.email;
    // String _company = _user.company;
    // String _id = _user.documentId;
    int page = 0;
    _homeBloc = HomeBloc(user: _user);
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return 
    // MultiBlocProvider(
    //     providers: [
    //       BlocProvider<HomeBloc>(
    //         create: (context) => HomeBloc(user: _user),
    //       ),
    //       // BlocProvider<AuthenticationBloc>(
    //       //   create: (context) => AuthenticationBloc(userRepository: _userRepository),
    //       // )],
    //     ],
    //     child: 
        // BlocBuilder<HomeBloc, HomeState>(
        //     bloc: _homeBloc,
        //     builder: (context, state) => 
            // Material(
            //       child:
                   Scaffold(
                    body: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width * .07,
                                child: Material(
                                  color: Theme.of(context).primaryColor,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Column(
                                            children: <Widget>[
                                              Icon(
                                                Icons.cloud,
                                                color: Colors.white,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .02,
                                              ),
                                              SizedBox(
                                                height: 22.5,
                                              ),
                                              Divider(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                height: 22.5,
                                              ),
                                              IconButton(
                                                  //Home Button
                                                  //Home Button
                                                  hoverColor: Colors.grey[300]
                                                      .withOpacity(.5),
                                                  icon: Icon(Icons.home),
                                                  color: page == 0
                                                      ? Colors.blueGrey
                                                      : Colors.white,
                                                  iconSize: 30,
                                                  onPressed: () {
                                                    page = 0;

                                                    _homeBloc.add(
                                                        HomeButtonPressed(
                                                            currentUser:
                                                                _user));
                                                  }),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              IconButton(
                                                  //Dashboard Button

                                                  hoverColor: Colors.grey[300]
                                                      .withOpacity(.5),
                                                  icon: Icon(Icons.dashboard),
                                                  color: page == 1
                                                      ? Colors.blueGrey
                                                      : Colors.white,
                                                  iconSize: 30,
                                                  onPressed: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             ClassificationMain()));
                                                    
                                                     page = 1;
                                                    _homeBloc.add(ProjectButtonPressed(currentUser: _user));

                                                  }),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              IconButton(
                                                  //Settings Button

                                                  hoverColor: Colors.grey[300]
                                                      .withOpacity(.5),
                                                  icon: Icon(Icons.settings),
                                                  color: page == 2
                                                      ? Colors.blueGrey
                                                      : Colors.white,
                                                  iconSize: 30,
                                                  onPressed: () {
                                                    page = 2;

                                                    _homeBloc.add(
                                                        SettingsButtonPressed(
                                                            currentUser:
                                                                _user));
                                                  }),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: Column(
                                            children: <Widget>[
                                              Divider(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                height: 22.5,
                                              ),
                                              IconButton(
                                                  //Log Out
                                                  hoverColor: Colors.grey[300]
                                                      .withOpacity(.5),
                                                  icon: Icon(
                                                    Icons.exit_to_app,
                                                    color: Colors.white,
                                                  ),
                                                  iconSize: 30,
                                                  onPressed: () {
                                                    setState(() {
                                                      authenticationBloc.add(
                                                        LoggedOut(),
                                                      );
                                                    });
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: BlocBuilder<HomeBloc, HomeState>(
                              bloc: _homeBloc,
                              builder: (context, state) {
                                if (state is ProjectState) {
                                    page = 1;
                                
                                  return ProjectsScreen(
                                    user: _user,
                                  );
                                }
                                 else if (state is HomeScreen1State){
                                   return Container(child: Home(company: _user.company,));
                                 }
                                else if (state is SettingsState) {
                                  return Container(child: SettingsHome());
                                } 
                                // else {
                                //   //return ClassificationMain();
                                // }
                              }
                              ),
                        )
                      ],
                    ),
                  );
               // )
                //)
                //);
  }
}
