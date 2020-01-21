import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user_repository.dart';
import '../login.dart';



class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: Row(
          children: <Widget>[
            Container(
          width: MediaQuery.of(context).size.width * .5,
          color: Colors.blue,
          child: Center(child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 50, color: Colors.white),
              children: <TextSpan> [
                TextSpan(text: "Procure", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "Centre", style: TextStyle(fontStyle: FontStyle.italic))
              ]
            ),
          ),),
        ),
            Container(
              width: MediaQuery.of(context).size.width * .5,
              child: LoginForm(userRepository: _userRepository)),
          ],
        ),
              ),
            );
          }
        }
        
