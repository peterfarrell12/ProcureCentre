import 'package:ProcureCentre/home/bloc/home_bloc.dart';
import 'package:ProcureCentre/simple_bloc_delegate.dart';
import 'package:ProcureCentre/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/user/authentication_bloc/bloc.dart';
import 'authentication/user/login/login.dart';
import 'authentication/user/user_repository.dart';
import 'home/screens/home_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted()),
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return BlocProvider<HomeBloc>(
              create: (context) => HomeBloc(user: state.user),
              child: HomeScreen(user: state.user, userRepository: _userRepository,),
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}