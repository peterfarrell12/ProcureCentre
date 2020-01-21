import 'package:ProcureCentre/authentication/company/company_register/bloc/company_register_bloc.dart';
import 'package:ProcureCentre/authentication/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../company_repository.dart';
import 'company_register_form.dart';

class CompanyRegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final CompanyRepository _companyRepository;

  CompanyRegisterScreen({Key key, @required UserRepository userRepository, @required CompanyRepository companyRepository})
      : assert(userRepository != null && companyRepository != null),
        _userRepository = userRepository,
        _companyRepository = companyRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<CompanyRegisterBloc>(
          create: (context) => CompanyRegisterBloc(companyRepository: _companyRepository),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .5,
                color: Colors.blue,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: 50, color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Procure",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "Centre",
                              style: TextStyle(fontStyle: FontStyle.italic))
                        ]),
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
                    CompanyRegisterForm(userRepository: _userRepository,),
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