import 'package:ProcureCentre/authentication/user/register/bloc/bloc.dart';
import 'package:ProcureCentre/authentication/user/register/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user_repository.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final String _companyName;

  RegisterScreen({Key key, @required UserRepository userRepository, @required String companyName})
      : assert(userRepository != null && companyName != null),
        _userRepository = userRepository,
        _companyName = companyName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .5,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.backup, size: 50, color: Colors.white),
                            ),

              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 50, color: Colors.white),
                  children: <TextSpan> [
                    TextSpan(text: "Procure", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "Centre", style: TextStyle(fontStyle: FontStyle.italic))
                    
                  ]
                ),
              ),
            ],
          ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .5,
                child:
                    //Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //children: <Widget>[
                    //Container(child: Icon(FontAwesomeIcons.bootstrap, size: 30, color: Colors.blue,),),
                    //SizedBox(height: 20,),
                    RegisterForm(companyName: _companyName,),
                // ],
                // )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
